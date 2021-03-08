# A custom command and target to turn the CUDA kernel into a byte array header
# The normal build depends on it properly and if the kernel file is changed, then
# a rebuild of libethash-cuda should be triggered

add_custom_command(
	OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/CUDAMiner_kernel.h
	COMMAND ${CMAKE_COMMAND} ARGS
	-DBIN2H_SOURCE_FILE="${CMAKE_CURRENT_SOURCE_DIR}/CUDAMiner_kernel.cu"
	-DBIN2H_VARIABLE_NAME=CUDAMiner_kernel
	-DBIN2H_HEADER_FILE="${CMAKE_CURRENT_BINARY_DIR}/CUDAMiner_kernel.h"
	-P "${CMAKE_CURRENT_SOURCE_DIR}/../cmake/bin2h.cmake"
	COMMENT "Generating CUDA Kernel Byte Array"
	DEPENDS ${CMAKE_CURRENT_SOURCE_DIR}/CUDAMiner_kernel.cu
)
add_custom_target(cuda_kernel DEPENDS ${CMAKE_CURRENT_BINARY_DIR}/CUDAMiner_kernel.h ${CMAKE_CURRENT_SOURCE_DIR}/CUDAMiner_kernel.cu)

find_package(CUDA REQUIRED)

set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS};--ptxas-options=-v;-lineinfo)

if (NOT MSVC)
	list(APPEND CUDA_NVCC_FLAGS "--disable-warnings")
endif()

list(APPEND CUDA_NVCC_FLAGS_RELEASE -O3)
list(APPEND CUDA_NVCC_FLAGS_DEBUG -G)

if(COMPUTE AND (COMPUTE GREATER 0))
	list(APPEND CUDA_NVCC_FLAGS "-gencode arch=compute_${COMPUTE},code=sm_${COMPUTE}")
else()
	set(
		CUDA_NVCC_FLAGS
		${CUDA_NVCC_FLAGS}
		"-gencode arch=compute_52,code=sm_52"
		"-gencode arch=compute_61,code=sm_61"
		"-gencode arch=compute_75,code=sm_75"
	)
endif()

file(GLOB sources CUDAMiner.cpp CUDAMiner_cuda.cu)
file(GLOB headers CUDAMiner.h CUDAMiner_cuda.h ${CMAKE_CURRENT_BINARY_DIR}/CUDAMiner_kernel.h)

# Cmake doesn't handle nvrtc automatically
find_library(CUDA_nvrtc_LIBRARY nvrtc "${CUDA_TOOLKIT_ROOT_DIR}/lib64" "${CUDA_TOOLKIT_ROOT_DIR}/lib/x64")
find_library(CUDA_cuda_LIBRARY cuda "${CUDA_TOOLKIT_ROOT_DIR}/lib64" "${CUDA_TOOLKIT_ROOT_DIR}/lib/x64")

cuda_add_library(ethash-cuda STATIC ${sources} ${headers})
add_dependencies(ethash-cuda cuda_kernel)
target_link_libraries(ethash-cuda ethcore ethash progpow)
target_link_libraries(ethash-cuda ${CUDA_nvrtc_LIBRARY} ${CUDA_cuda_LIBRARY})
target_include_directories(ethash-cuda PRIVATE .. ${CMAKE_CURRENT_BINARY_DIR})
