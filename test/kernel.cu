// Inner loop for prog_seed 3,000
DEV_INLINE void progPowLoop(const uint32_t loop,
    uint32_t mix[PROGPOW_REGS],
    const dag_t* g_dag,
    const uint32_t c_dag[PROGPOW_CACHE_WORDS],
    const bool hack_false,
    const uint32_t lane_id)
{
    dag_t data_dag;
    uint32_t offset, data;
    // global load
    offset = _SHFL(mix[0], loop & (PROGPOW_LANES - 1), PROGPOW_LANES);
    offset %= PROGPOW_DAG_ELEMENTS;
    offset = offset * PROGPOW_LANES + ((lane_id ^ loop) & (PROGPOW_LANES - 1));
    data_dag = g_dag[offset];
    // hack to prevent compiler from reordering LD and usage
    if (hack_false) __threadfence_block();
    // cache load 0
    offset = mix[12] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[26] = ROTR32(mix[26], 17) ^ data;
    // random math 0
    data = mix[13] ^ mix[3];
    mix[9] = ROTL32(mix[9], 17) ^ data;
    // cache load 1
    offset = mix[1] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[15] = ROTL32(mix[15], 15) ^ data;
    // random math 1
    data = mix[24] ^ mix[10];
    mix[16] = (mix[16] * 33) + data;
    // cache load 2
    offset = mix[29] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[25] = (mix[25] ^ data) * 33;
    // random math 2
    data = ROTL32(mix[4], mix[12]);
    mix[12] = ROTR32(mix[12], 13) ^ data;
    // cache load 3
    offset = mix[6] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[7] = ROTL32(mix[7], 8) ^ data;
    // random math 3
    data = mix[8] * mix[24];
    mix[31] = (mix[31] ^ data) * 33;
    // cache load 4
    offset = mix[11] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[27] = ROTL32(mix[27], 2) ^ data;
    // random math 4
    data = popcount(mix[28]) + popcount(mix[17]);
    mix[5] = (mix[5] * 33) + data;
    // cache load 5
    offset = mix[18] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[11] = ROTR32(mix[11], 28) ^ data;
    // random math 5
    data = mix[31] ^ mix[12];
    mix[17] = (mix[17] ^ data) * 33;
    // cache load 6
    offset = mix[8] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[29] = ROTR32(mix[29], 10) ^ data;
    // random math 6
    data = popcount(mix[4]) + popcount(mix[12]);
    mix[10] = (mix[10] * 33) + data;
    // cache load 7
    offset = mix[14] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[6] = (mix[6] ^ data) * 33;
    // random math 7
    data = min(mix[10], mix[20]);
    mix[24] = (mix[24] * 33) + data;
    // cache load 8
    offset = mix[17] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[14] = (mix[14] ^ data) * 33;
    // random math 8
    data = mix[0] * mix[10];
    mix[19] = ROTR32(mix[19], 23) ^ data;
    // cache load 9
    offset = mix[9] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[23] = (mix[23] * 33) + data;
    // random math 9
    data = min(mix[22], mix[28]);
    mix[1] = ROTR32(mix[1], 4) ^ data;
    // cache load 10
    offset = mix[0] & (PROGPOW_CACHE_WORDS - 1);
    data = c_dag[offset];
    mix[18] = (mix[18] ^ data) * 33;
    // random math 10
    data = ROTL32(mix[22], mix[9]);
    mix[21] = ROTR32(mix[21], 5) ^ data;
    // random math 11
    data = min(mix[26], mix[4]);
    mix[22] = (mix[22] * 33) + data;
    // random math 12
    data = min(mix[19], mix[30]);
    mix[8] = ROTL32(mix[8], 26) ^ data;
    // random math 13
    data = mix[12] ^ mix[24];
    mix[3] = ROTL32(mix[3], 30) ^ data;
    // random math 14
    data = min(mix[8], mix[13]);
    mix[28] = ROTL32(mix[28], 31) ^ data;
    // random math 15
    data = ROTL32(mix[12], mix[9]);
    mix[30] = ROTL32(mix[30], 31) ^ data;
    // random math 16
    data = ROTL32(mix[28], mix[27]);
    mix[2] = (mix[2] * 33) + data;
    // random math 17
    data = ROTL32(mix[30], mix[28]);
    mix[20] = ROTL32(mix[20], 12) ^ data;
    // consume global load data
    // hack to prevent compiler from reordering LD and usage
    if (hack_false) __threadfence_block();
    mix[0] = (mix[0] * 33) + data_dag.words[0];
    mix[4] = ROTL32(mix[4], 13) ^ data_dag.words[1];
    mix[13] = (mix[13] ^ data_dag.words[2]) * 33;
    mix[0] = ROTR32(mix[0], 12) ^ data_dag.words[3];
}
