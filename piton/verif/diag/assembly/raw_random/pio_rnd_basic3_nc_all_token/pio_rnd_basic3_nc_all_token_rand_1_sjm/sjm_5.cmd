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

WRITEBLKIO  0x0000061b29aa72c0 +
        0xa1d74bd1 0x0976a781 0xc0bad7a5 0xaf5e61e9 +
        0x65b670fd 0x0cfbb38c 0xb05fd1e0 0xd4223d0e +
        0x6626211c 0xfd7a6946 0x9dd515df 0x74a86668 +
        0x32e70ebc 0x9f6c33c6 0x04ccb5b8 0xc99f5728 

WRITEBLKIO  0x000006182a5486c0 +
        0xae22e710 0xea9576c5 0x9a525dcb 0xb545e799 +
        0x2ed7d237 0x3c464f15 0x7b6d71a0 0xc0983c84 +
        0x2a9b0984 0xaf0a72f1 0x9ea7bf02 0x3eda2b83 +
        0x56982cb7 0x46afb8f6 0x3ed5cdef 0xa724a2be 

READBLKIO  0x0000061b29aa72c0 +
        0xa1d74bd1 0x0976a781 0xc0bad7a5 0xaf5e61e9 +
        0x65b670fd 0x0cfbb38c 0xb05fd1e0 0xd4223d0e +
        0x6626211c 0xfd7a6946 0x9dd515df 0x74a86668 +
        0x32e70ebc 0x9f6c33c6 0x04ccb5b8 0xc99f5728 

READBLKIO  0x000006182a5486c0 +
        0xae22e710 0xea9576c5 0x9a525dcb 0xb545e799 +
        0x2ed7d237 0x3c464f15 0x7b6d71a0 0xc0983c84 +
        0x2a9b0984 0xaf0a72f1 0x9ea7bf02 0x3eda2b83 +
        0x56982cb7 0x46afb8f6 0x3ed5cdef 0xa724a2be 

WRITEBLK  0x0000001a141543c0 +
        0x115cd451 0x8ec19ce2 0xae1694b8 0xdc87114b +
        0xcb5a628f 0x1a752dc4 0xaa2b9bc3 0x06f0de87 +
        0xeb361eb0 0xcc500064 0xdb6a78a0 0x58007f0e +
        0x0b230065 0xe9b03347 0x456dfae2 0x2396bec9 

WRITEMSKIO  0x0000060a58550540 0x0ff0  0x00000000 0x26e4cce2 0x629d3084 0x00000000 

WRITEIO  0x0000061d5e83aec0 8 0x7e347525 0xb7e0485c 

WRITEBLKIO  0x000006147c804a00 +
        0x4c271c7a 0xa7e10fd3 0x3f6e73d8 0x77d8491d +
        0x64691faa 0x50384b20 0x1ec5579a 0x3f0de731 +
        0x4a38172b 0x3420aeaf 0xfc2a67d9 0xfda045a5 +
        0xdc11c134 0x9392c9e6 0x60c24507 0xe8538624 

WRITEBLK  0x0000000e12dad900 +
        0x48dbe4b4 0xc4fb667f 0x7316783c 0xaf36c419 +
        0x36e7685d 0xadbce206 0x2c51b605 0x436c154b +
        0x78f02d73 0x2ddfcf4b 0x90114bcb 0xf13bfe39 +
        0xacd43831 0x5d37edbc 0x6af045a4 0x346a8d3d 

WRITEMSKIO  0x0000060deb79c100 0xf000  0x35ef83d7 0x00000000 0x00000000 0x00000000 

WRITEMSKIO  0x0000061ed4004d00 0x00ff  0x00000000 0x00000000 0xa9b8fad8 0x93ec9a84 

READBLK  0x0000001a141543c0 +
        0x115cd451 0x8ec19ce2 0xae1694b8 0xdc87114b +
        0xcb5a628f 0x1a752dc4 0xaa2b9bc3 0x06f0de87 +
        0xeb361eb0 0xcc500064 0xdb6a78a0 0x58007f0e +
        0x0b230065 0xe9b03347 0x456dfae2 0x2396bec9 

READBLK  0x0000000e12dad900 +
        0x48dbe4b4 0xc4fb667f 0x7316783c 0xaf36c419 +
        0x36e7685d 0xadbce206 0x2c51b605 0x436c154b +
        0x78f02d73 0x2ddfcf4b 0x90114bcb 0xf13bfe39 +
        0xacd43831 0x5d37edbc 0x6af045a4 0x346a8d3d 

WRITEMSKIO  0x000006049a53b080 0x0ff0  0x00000000 0x3b614a63 0x6dd50d08 0x00000000 

READIO  0x0000061d5e83aec0 8 0x7e347525 0xb7e0485c 
READMSKIO   0x0000060a58550540 0x0ff0  0x00000000 0x26e4cce2 0x629d3084 0x00000000 

READMSKIO   0x0000060deb79c100 0xf000  0x35ef83d7 0x00000000 0x00000000 0x00000000 

WRITEIO  0x0000061b8fb6c900 8 0xfadb753c 0x17bfdba3 

READBLKIO  0x000006147c804a00 +
        0x4c271c7a 0xa7e10fd3 0x3f6e73d8 0x77d8491d +
        0x64691faa 0x50384b20 0x1ec5579a 0x3f0de731 +
        0x4a38172b 0x3420aeaf 0xfc2a67d9 0xfda045a5 +
        0xdc11c134 0x9392c9e6 0x60c24507 0xe8538624 

WRITEBLK  0x0000000ff6e72200 +
        0xfd8681e5 0x9d89e44d 0xfaffeafd 0x3e868806 +
        0x1d1663a8 0xa6b0e7db 0xfc1bfa1e 0x68f9717e +
        0x84b24bba 0x9327d165 0x6905030a 0x082c01f3 +
        0xd28aba77 0x9e5f3f55 0x990e3ebc 0x526b4394 

READIO  0x0000061b8fb6c900 8 0xfadb753c 0x17bfdba3 
READBLK  0x0000000ff6e72200 +
        0xfd8681e5 0x9d89e44d 0xfaffeafd 0x3e868806 +
        0x1d1663a8 0xa6b0e7db 0xfc1bfa1e 0x68f9717e +
        0x84b24bba 0x9327d165 0x6905030a 0x082c01f3 +
        0xd28aba77 0x9e5f3f55 0x990e3ebc 0x526b4394 

WRITEBLK  0x00000003c2956e00 +
        0xfe01cbe3 0x7be47052 0x90e85dca 0xddcf6c24 +
        0xbed3c56d 0x76d37196 0x7a68c4d3 0xb83bf999 +
        0xbda514fd 0xc9824380 0x7f8d7db8 0x9b8e00cf +
        0x4e8de1c3 0xf938b07c 0xa07d58c8 0x9695de9f 

WRITEMSK  0x00000003c2956e00 0x0ff0f0ff0ff0f000 +
        0x00000000 0x0e600631 0x0a06dd63 0x00000000 +
        0x68284e59 0x00000000 0x72059571 0x58f8dbd5 +
        0x00000000 0xb7db3581 0xc29677f4 0x00000000 +
        0x82175c76 0x00000000 0x00000000 0x00000000 

READBLK  0x00000003c2956e00 +
        0xfe01cbe3 0x0e600631 0x0a06dd63 0xddcf6c24 +
        0x68284e59 0x76d37196 0x72059571 0x58f8dbd5 +
        0xbda514fd 0xb7db3581 0xc29677f4 0x9b8e00cf +
        0x82175c76 0xf938b07c 0xa07d58c8 0x9695de9f 

READMSKIO   0x0000061ed4004d00 0x00ff  0x00000000 0x00000000 0xa9b8fad8 0x93ec9a84 

WRITEBLKIO  0x0000061dbfa56780 +
        0xed6542e0 0x0d04efda 0x021ec4b0 0x56081050 +
        0x8cd00e86 0x1c5056db 0xe75ea5ad 0xf0df68b8 +
        0x37049484 0x9f5fe21e 0x535f7558 0xf5593ebf +
        0xbc418e7c 0x9c54ebab 0x538c354f 0x8ea6e95a 

READBLKIO  0x0000061dbfa56780 +
        0xed6542e0 0x0d04efda 0x021ec4b0 0x56081050 +
        0x8cd00e86 0x1c5056db 0xe75ea5ad 0xf0df68b8 +
        0x37049484 0x9f5fe21e 0x535f7558 0xf5593ebf +
        0xbc418e7c 0x9c54ebab 0x538c354f 0x8ea6e95a 

WRITEBLKIO  0x00000618c94f0140 +
        0x642480f3 0x350935f7 0xc69ee713 0x8077e1f3 +
        0x70a4c3bd 0xcc92c025 0xa3c04944 0xec813a19 +
        0xc5c33701 0xe4ab9814 0xd02051d4 0x723b97ac +
        0x77109775 0x9ad58ba5 0x021b6090 0xa84483df 

WRITEMSKIO  0x0000060c09e1ffc0 0xffff  0xc529316e 0xb88bb927 0xfb184253 0x1f5b355e 

WRITEBLKIO  0x0000060897496a00 +
        0xf99a8855 0x2bbcf2ed 0xa2ee75c3 0x611c5d0c +
        0x6d69c098 0xea4be5a1 0x21e086cb 0x36e3d05b +
        0x72cace18 0x1d0c1aa1 0xdfdd75b2 0xa365065d +
        0x9e32aff8 0x9358fceb 0xd21a9ba1 0x89ac5178 

WRITEIO  0x0000060b5c7f5b00 4 0xc4642394 

READBLKIO  0x00000618c94f0140 +
        0x642480f3 0x350935f7 0xc69ee713 0x8077e1f3 +
        0x70a4c3bd 0xcc92c025 0xa3c04944 0xec813a19 +
        0xc5c33701 0xe4ab9814 0xd02051d4 0x723b97ac +
        0x77109775 0x9ad58ba5 0x021b6090 0xa84483df 

WRITEBLK  0x00000011b78b3f40 +
        0x7489fa4c 0x71fc0cf0 0xf46a1286 0xa7945292 +
        0x32dda592 0x1dd14c81 0x3b9ca5d3 0xcfef7c82 +
        0xd76558c9 0xbcce016f 0xef871251 0x0e27c3da +
        0x52863a5a 0x7e14f2dd 0x7e64234d 0x17c62e81 

WRITEMSKIO  0x00000611f16b3cc0 0x00ff  0x00000000 0x00000000 0x37650c5b 0x01ce31c6 


BA LABEL_0
