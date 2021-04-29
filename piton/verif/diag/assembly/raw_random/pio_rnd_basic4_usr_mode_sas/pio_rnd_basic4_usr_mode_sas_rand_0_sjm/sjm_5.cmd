# Modified by Princeton University on June 9th, 2015
# ========== Copyright Header Begin ==========================================
# 
# OpenSPARC T1 Processor File: sjm_5.cmd
# Copyright (c) 2006 Sun Microsystems, Inc.  All Rights Reserved.
# DO NOT ALTER OR REMOVE COPYRIGHT NOTICES.
# 
# The above named program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public
# License version 2 as published by the Free Software Foundation.
# 
# The above named program is distributed in the hope that it will be 
# useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
# General Public License for more details.
# 
# You should have received a copy of the GNU General Public
# License along with this work; if not, write to the Free Software
# Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA.
# 
# ========== Copyright Header End ============================================
CONFIG id=30 iosyncadr=0x7EF00BEEF00
TIMEOUT 10000000
IOSYNC
#==================================================
#==================================================


LABEL_0:

WRITEBLK  0x000000182401c5c0 +
        0xfd4742d6 0x7008d816 0x64c8fca3 0xe5aee262 +
        0xb4c2682c 0x14dcdf5c 0x26aecb03 0x9b062fd8 +
        0x3ef80e57 0xc1bf1acf 0x33899852 0x6551c492 +
        0xc4703b5b 0x1e0c23f1 0x2ac1a81c 0x776ff490 

WRITEBLKIO  0x0000060a67f96b40 +
        0x73051a82 0x25d50100 0xe0126e51 0xbb089e75 +
        0x3116b145 0x0e129926 0x1a2e4d9a 0x2a35c2fa +
        0x39173fa3 0x6a0633ff 0x98e85794 0xc30be8a4 +
        0xc423b7f2 0x4cad2b31 0x548bf2e2 0x0632b4e9 

READBLKIO  0x0000060a67f96b40 +
        0x73051a82 0x25d50100 0xe0126e51 0xbb089e75 +
        0x3116b145 0x0e129926 0x1a2e4d9a 0x2a35c2fa +
        0x39173fa3 0x6a0633ff 0x98e85794 0xc30be8a4 +
        0xc423b7f2 0x4cad2b31 0x548bf2e2 0x0632b4e9 

READBLK  0x000000182401c5c0 +
        0xfd4742d6 0x7008d816 0x64c8fca3 0xe5aee262 +
        0xb4c2682c 0x14dcdf5c 0x26aecb03 0x9b062fd8 +
        0x3ef80e57 0xc1bf1acf 0x33899852 0x6551c492 +
        0xc4703b5b 0x1e0c23f1 0x2ac1a81c 0x776ff490 

WRITEBLK  0x0000001fe67b9b80 +
        0x1cd5558e 0xdbd68443 0x7c3cf699 0xd2d51e8f +
        0xb8492248 0x5b8f1924 0x760540bb 0x96d07f4e +
        0x5f9a453b 0x4ba5b491 0xa04fd587 0x6724ecee +
        0xa76897a8 0x9436e46e 0xa5160324 0x08fb92cf 

WRITEMSK  0x0000001fe67b9b80 0xfffff0f0f00000f0 +
        0x3d271560 0x4c5bb08a 0x7f7736ce 0xe2db89a8 +
        0xa1e4786a 0x00000000 0xb6698710 0x00000000 +
        0xceaa725c 0x00000000 0x00000000 0x00000000 +
        0x00000000 0x00000000 0x199ef165 0x00000000 

READBLK  0x0000001fe67b9b80 +
        0x3d271560 0x4c5bb08a 0x7f7736ce 0xe2db89a8 +
        0xa1e4786a 0x5b8f1924 0xb6698710 0x96d07f4e +
        0xceaa725c 0x4ba5b491 0xa04fd587 0x6724ecee +
        0xa76897a8 0x9436e46e 0x199ef165 0x08fb92cf 

WRITEMSKIO  0x000006016b112900 0xfff0  0xbe3af5b9 0xd1fa07eb 0x907689a0 0x00000000 

WRITEBLKIO  0x000006157faab140 +
        0xcb159e49 0xd56286a8 0xc019819e 0xf4e54d25 +
        0xee11a777 0x4b047af3 0x5e46d849 0x142a4e22 +
        0xc45a668a 0x23c6c54b 0xa1702339 0x2444e049 +
        0x02401d6e 0x245fc4a5 0xe62d6965 0x8d9d3a3b 

WRITEMSKIO  0x0000061f86ca89c0 0x0fff  0x00000000 0x3a3da999 0x42f3ebcb 0xf30d3802 

WRITEBLKIO  0x0000060529095000 +
        0x2c21019a 0xc8af3659 0xd77c8cb7 0x7a7ea058 +
        0x27fccbc4 0x403fcd7d 0x879a38d2 0x36a61708 +
        0xfbba47ce 0x1a8685f0 0x0dda0e9e 0x4c16160c +
        0x83d88ae2 0x300af50d 0x6e987fb2 0x0e4621e6 

WRITEMSKIO  0x0000060bed1b1580 0xff00  0x661b7b9d 0xb9ec6627 0x00000000 0x00000000 

WRITEIO  0x0000061228c93380 8 0xf1cf359b 0x74497a81 

WRITEMSKIO  0x000006058ddfdd40 0xf000  0xf9c0190d 0x00000000 0x00000000 0x00000000 

WRITEBLKIO  0x00000616b3b17c00 +
        0xbeec75f8 0x6b7456d1 0x97d21fa4 0x71b6a137 +
        0x927bac00 0x8f80fc32 0xba90828f 0xe7bf2380 +
        0x348e04fa 0x87b51eaa 0xfe8732d0 0x2cda70d5 +
        0x2025b93f 0x422a1901 0x66b1984b 0xc6d726c2 

WRITEBLKIO  0x0000061a0c3935c0 +
        0x96279d78 0x52ecf79a 0xfc4286e1 0xdc4ced59 +
        0x1b54c7c7 0xf32bbfb2 0x33ef3385 0xbad66ef9 +
        0x1daae572 0x02cedd8b 0xd1b7a33b 0x38cd90bd +
        0xddb21b66 0x14ed876b 0x8f7e1697 0xb7db1f2c 

WRITEBLKIO  0x00000606b0c84980 +
        0xdde3f3d6 0x603bbb3b 0x1afd38e8 0x6955c562 +
        0xf33df6f0 0xb9a8a579 0x3080828b 0x1d66eb0e +
        0x8606e058 0x5048188c 0x4605f917 0xbf6a50a0 +
        0xb4a356df 0x79d1ae9e 0xdd4bb519 0xe52a49c5 

WRITEMSKIO  0x0000061771488e80 0xf000  0xb722b7d2 0x00000000 0x00000000 0x00000000 

WRITEBLK  0x00000004cf099c40 +
        0x7af87fd8 0x5d362911 0x3f4972e8 0xc2b075ac +
        0x16ee1696 0x041769e0 0x6fa3042a 0x21d94c33 +
        0x6a7bd0d7 0x844cdcb6 0x388108dc 0xd344a803 +
        0xece38129 0xb1d55954 0xa22af9eb 0xfde8ed2f 

WRITEMSKIO  0x0000061b4217ee80 0x0fff  0x00000000 0x0ed46ec2 0x0b6010ff 0xc279470a 

WRITEMSKIO  0x0000060a57783740 0xf0f0  0xaa5087b6 0x00000000 0x8e9c37f4 0x00000000 

READIO  0x0000061228c93380 8 0xf1cf359b 0x74497a81 
WRITEIO  0x00000611ade58c80 4 0x151569e7 

WRITEBLKIO  0x0000060de82ee5c0 +
        0xb8eed2d4 0x688e435b 0xd8c3930f 0x86c5cae2 +
        0x5d1d6cf3 0x19cfedb9 0xd19107dc 0x7675d77b +
        0x2a6b0bff 0x3669a0a2 0x618d1e61 0x5d11bdc7 +
        0x57c9741a 0x1debe0f3 0xdae6af67 0xe83e7136 

WRITEMSKIO  0x000006149905ef80 0xff0f  0x18bd54d2 0x6b5152c5 0x00000000 0x673d19c0 

READBLK  0x00000004cf099c40 +
        0x7af87fd8 0x5d362911 0x3f4972e8 0xc2b075ac +
        0x16ee1696 0x041769e0 0x6fa3042a 0x21d94c33 +
        0x6a7bd0d7 0x844cdcb6 0x388108dc 0xd344a803 +
        0xece38129 0xb1d55954 0xa22af9eb 0xfde8ed2f 

WRITEBLK  0x00000005abaf80c0 +
        0x47d8c51b 0x6d784d92 0x9d0d2141 0xeb41f9eb +
        0x4ae1c3ad 0x5b08c549 0x3a6cc92e 0x1fbd7b68 +
        0x1a526cd6 0xbdbafebc 0x0b5e2db1 0x2294b82e +
        0x4c4c30c9 0x8a2c212a 0x093b2b0e 0x93c99e6d 

READBLKIO  0x000006157faab140 +
        0xcb159e49 0xd56286a8 0xc019819e 0xf4e54d25 +
        0xee11a777 0x4b047af3 0x5e46d849 0x142a4e22 +
        0xc45a668a 0x23c6c54b 0xa1702339 0x2444e049 +
        0x02401d6e 0x245fc4a5 0xe62d6965 0x8d9d3a3b 

WRITEBLKIO  0x0000061aca826840 +
        0x58f03764 0x0ad16b25 0x4d3648c0 0xcbae52fd +
        0x85a88b10 0x1ea93e20 0x332475b8 0x345b8f96 +
        0x4106fa64 0x496244be 0xdaa27630 0x414e0408 +
        0x9b09d7fa 0xfa97f0f3 0xbaabda60 0xafc42c1f 

READBLK  0x00000005abaf80c0 +
        0x47d8c51b 0x6d784d92 0x9d0d2141 0xeb41f9eb +
        0x4ae1c3ad 0x5b08c549 0x3a6cc92e 0x1fbd7b68 +
        0x1a526cd6 0xbdbafebc 0x0b5e2db1 0x2294b82e +
        0x4c4c30c9 0x8a2c212a 0x093b2b0e 0x93c99e6d 

READIO  0x00000611ade58c80 4 0x151569e7 
WRITEIO  0x00000605f8c41140 16 0x55c9fa01 0x74d33080 0x42e8ec09 0x86f31f12 

WRITEBLKIO  0x0000061c4e0b3600 +
        0xc97f96d2 0xf08002e6 0x8baeeeb2 0xf5d39d97 +
        0x14228255 0xff9e7e71 0xa2a94057 0xd52550f1 +
        0x6fbadf32 0x93ac26f9 0xbd5256bc 0xac70d920 +
        0x9b868ade 0xcc1c7f45 0xdea99b46 0xe2578491 

READBLKIO  0x0000060529095000 +
        0x2c21019a 0xc8af3659 0xd77c8cb7 0x7a7ea058 +
        0x27fccbc4 0x403fcd7d 0x879a38d2 0x36a61708 +
        0xfbba47ce 0x1a8685f0 0x0dda0e9e 0x4c16160c +
        0x83d88ae2 0x300af50d 0x6e987fb2 0x0e4621e6 

READBLKIO  0x00000616b3b17c00 +
        0xbeec75f8 0x6b7456d1 0x97d21fa4 0x71b6a137 +
        0x927bac00 0x8f80fc32 0xba90828f 0xe7bf2380 +
        0x348e04fa 0x87b51eaa 0xfe8732d0 0x2cda70d5 +
        0x2025b93f 0x422a1901 0x66b1984b 0xc6d726c2 


BA LABEL_0
