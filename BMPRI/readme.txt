
============================================================================================
The blind multiple pseudo reference image based (BMPRI) quality measure
Copyright(c) 2018 Xiongkuo Min, Guangtao Zhai, Ke Gu, Yutao Liu, and Xiaokang Yang
All Rights Reserved.

--------------------------------------------------------------------------------------------
Permission to use, copy, or modify this software and its documentation for educational
and research purposes only and without fee is hereby granted, provided that this copyright
notice and the original authors' names appear on all copies and supporting documentation.
This software shall not be used, redistributed, or adapted as the basis of a commercial
software or hardware product without first obtaining permission of the authors. The authors
make no representations about the suitability of this software for any purpose. It is
provided "as is" without express or implied warranty.
--------------------------------------------------------------------------------------------

This is the blind multiple pseudo reference image based (BMPRI) measure described in the 
following paper:

Xiongkuo Min, Guangtao Zhai, Ke Gu, Yutao Liu, and Xiaokang Yang, "Blind Image Quality 
Estimation via Distortion Aggravation," IEEE Transactions on Broadcasting, 2018.

Please contact Xiongkuo Min (minxiongkuo@gmail.com) if you have any questions.

--------------------------------------------------------------------------------------------

Demo code:
demo.m

The BMPRI quality measure:
function score = BMPRI(img)
% Input : (1) img: a RGB or gray scale image, and the dynamic range should be 0-255.
% Output: (1) score: the quality score
% Usage:  Given a RGB or gray scale test image img, whose dynamic range is 0-255
%         score = BMPRI(img);

============================================================================================
