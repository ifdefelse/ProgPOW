# Test Vectors for ProgPow

Many of these vectors are dervived from [chfast/ethash](https://github.com/chfast/ethash)

## fnv1a

|          `h` |          `d` |     _result_ |
| -----------: | -----------: | -----------: |
| `0X811C9DC5` | `0XDDD0A47B` | `0XD37EE61A` |
| `0XD37EE61A` | `0XEE304846` | `0XDEDC7AD4` |
| `0XDEDC7AD4` | `0X00000000` | `0XA9155BBC` |

## kiss99

For `z`=`362436069`, `w`=`521288629`, `jsr`=`123456789`, and `jcong`=`380116160` the result of each iterative call to `kiss99` is as follows:

| _iteration_ |     _result_ |
| ----------: | -----------: |
|         `1` |  `769445856` |
|         `2` |  `742012328` |
|         `3` | `2121196314` |
|         `4` | `2805620942` |
|    `100000` |  `941074834` |

## fill_mix

For `seed`=`0xEE304846DDD0A47B` and `lane_id`=`0` the values stored in the `mix` array will be

> ```
> 0x10C02F0D, 0x99891C9E, 0xC59649A0, 0x43F0394D,
> 0x24D2BAE4, 0xC4E89D4C, 0x398AD25C, 0xF5C0E467,
> 0x7A3302D6, 0xE6245C6C, 0x760726D3, 0x1F322EE7,
> 0x85405811, 0xC2F1E765, 0xA0EB7045, 0xDA39E821,
> 0x79FC6A48, 0x089E401F, 0x8488779F, 0xD79E414F,
> 0x041A826B, 0x313C0D79, 0x10125A3C, 0x3F4BDFAC,
> 0xA7352F36, 0x7E70CB54, 0x3B0BB37D, 0x74A3E24A,
> 0xCC37236A, 0xA442B311, 0x955AB27A, 0x6D175B7E
> ```

For the same hash and `lane_id`=`13` the value in the `mix` array will be

> ```
> 0x4E46D05D, 0x2E77E734, 0x2C479399, 0x70712177,
> 0xA75D7FF5, 0xBEF18D17, 0x8D42252E, 0x35B4FA0E,
> 0x462C850A, 0x2DD2B5D5, 0x5F32B5EC, 0xED5D9EED,
> 0xF9E2685E, 0x1F29DC8E, 0xA78F098B, 0x86A8687B,
> 0xEA7A10E7, 0xBE732B9D, 0x4EEBCB60, 0x94DD7D97,
> 0x39A425E9, 0xC0E782BF, 0xBA7B870F, 0x4823FF60,
> 0xF97A5A1C, 0xB00BCAF4, 0x02D0F8C4, 0x28399214,
> 0xB4CCB32D, 0x83A09132, 0x27EA8279, 0x3837DDA3
> ```

## progPowInit

For ProgPow period 600 (block 30,000) the configurations should be

src array:

> `0x1A`, `0x1E`, `0x01`, `0x13`, `0x0B`, `0x15`, `0x0F`, `0x12`,
> `0x03`, `0x11`, `0x1F`, `0x10`, `0x1C`, `0x04`, `0x16`, `0x17`,
> `0x02`, `0x0D`, `0x1D`, `0x18`, `0x0A`, `0x0C`, `0x05`, `0x14`,
> `0x07`, `0x08`, `0x0E`, `0x1B`, `0x06`, `0x19`, `0x09`, `0x00`

dst array

> `0x00`, `0x04`, `0x1B`, `0x1A`, `0x0D`, `0x0F`, `0x11`, `0x07`,
> `0x0E`, `0x08`, `0x09`, `0x0C`, `0x03`, `0x0A`, `0x01`, `0x0B`,
> `0x06`, `0x10`, `0x1C`, `0x1F`, `0x02`, `0x13`, `0x1E`, `0x16`,
> `0x1D`, `0x05`, `0x18`, `0x12`, `0x19`, `0x17`, `0x15`, `0x14`

Kiss 99 state:
`z`=`0x6535921C` `w`=`0x29345B16`, `jsr`=`0xC0DD7F78`, `jcong`=`0x1165D7EB`

## merge

| `a`          | `b`          | `r`          | _result_     | _path exercised_ |
| ------------ | ------------ | ------------ | ------------ | ---------------- |
| `0x3B0BB37D` | `0xA0212004` | `0x9BD26AB0` | `0x3CA34321` | mul/add          |
| `0x10C02F0D` | `0x870FA227` | `0xD4F45515` | `0x91C1326A` | xor/mul          |
| `0x24D2BAE4` | `0x0FFB4C9B` | `0x7FDBC2F2` | `0x2EDDD94C` | rotl/xor         |
| `0xDA39E821` | `0x089C4008` | `0x8B6CD8C3` | `0x8A81E396` | rotr/xor         |

## math

| `a`          | `b`          | `r`          | _result_     | _operation exercised_   |
| ------------ | ------------ | ------------ | ------------ | ----------------------- |
| `0x8626BB1F` | `0xBBDFBC4E` | `0x883E5B49` | `0x4206776D` | add                     |
| `0x3F4BDFAC` | `0xD79E414F` | `0x36B71236` | `0x4C5CB214` | mul                     |
| `0x6D175B7E` | `0xC4E89D4C` | `0x944ECABB` | `0x53E9023F` | mul_hi32                |
| `0x2EDDD94C` | `0x7E70CB54` | `0x3F472A85` | `0x2EDDD94C` | min                     |
| `0x61AE0E62` | `0xe0596b32` | `0x3F472A85` | `0x61AE0E62` | min again (unsigned)    |
| `0x8A81E396` | `0x3F4BDFAC` | `0xCEC46E67` | `0x1E3968A8` | rotl32                  |
| `0x8A81E396` | `0x7E70CB54` | `0xDBE71FF7` | `0x1E3968A8` | rotr32                  |
| `0xA7352F36` | `0xA0EB7045` | `0x59E7B9D8` | `0xA0212004` | bitwise and             |
| `0xC89805AF` | `0x64291E2F` | `0x1BDC84A9` | `0xECB91FAF` | bitwise or              |
| `0x760726D3` | `0x79FC6A48` | `0xC675CAC5` | `0x0FFB4C9B` | bitwise xor             |
| `0x75551D43` | `0x3383BA34` | `0x2863AD31` | `0x00000003` | clz (leading zeros)     |
| `0xEA260841` | `0xE92C44B7` | `0xF83FFE7D` | `0x0000001B` | popcount (number of 1s) |

## progPowLoop

For the first loop iteration of block 30,000 the seed to use for `fill_mix`
would be `0x7ba4d0dd464830ee`. A two dimensional `mix` array should be created
passing the rows into `fill_mix` with the column number as the loop argument.

The state of the mix array after the call to `progPowLoop` for block 30,000, 
loop 1 are as follows.

[TO DO]

## progPowHash

Block 0:
```
Header     : 0xffeeddccbbaa9988776655443322110000112233445566778899aabbccddeeff
Nonce      : 0x123456789abcdef0
Hash init  : 0x820cbdad61f9121f6d516f1758b5d73994ac00854ff1ddeef0b7701df5caa0fe
Mix hash   : 0x649bf3c6c69d7f1d86d114341f39cc27f69d4b8f39fa92e30fbafba48562cbab
Hash final : 0x2ae94b9ded0f6bac6cdb4348a6481c3ca07899aef390585a19a38a554ac25228
```

Block 30,000:
```
Header     : 0xffeeddccbbaa9988776655443322110000112233445566778899aabbccddeeff
Nonce      : 0x123456789abcdef0
Hash init  : 0x820cbdad61f9121f6d516f1758b5d73994ac00854ff1ddeef0b7701df5caa0fe
Mix hash   : 0xca62b7dfb3b5e713ad23f5c70fea05a888f76b13af7998af1db374d5f6f9f77f
Hash final : 0x21fbd7b6c3069edebb514eb0ab76178a3b9a1d8ed9066af4f70e063670dec958
```
