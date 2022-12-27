//SHA-1 c코드
//2020112099_송민지

#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

char input[129];
long long w[80];
long long t = 0;


long long A = 0x67452301;
long long B = 0xEFCDAB89;
long long C = 0x98BADCFE;
long long D = 0x10325476;
long long E = 0xC3D2E1F0;

long long temp_a=0, temp_a1=0;
long long a = 0x67452301;
long long b = 0xEFCDAB89;
long long c = 0x98BADCFE;
long long d = 0x10325476; 
long long e = 0xC3D2E1F0;

long long x = 0;

long long string_to_hex(char *input);
long long F(long long t, long long b, long long c, long long d);
long long K(long long t);
long long circular_left_shift(long long temp, long long num);

int main(void)
{
	printf("Input string: ");
	scanf("%s", input); //128개

	for (int t = 0; t < 80; t++)
	{
		if (t < 16)
			w[t] = string_to_hex(8 * t + input);
		else
			w[t] = circular_left_shift((w[t - 3] ^ w[t - 8] ^ w[t - 14] ^ w[t - 16]), 1);

		w[t] = w[t] & 0XFFFFFFFF;
	}

	printf("<Round Output> \n");

	for (int t = 0; t < 20; t++)//round1
	{
		temp_a = e + F(t, b, c, d) + circular_left_shift(a, 5) + w[t] + K(t);
		temp_a1 = temp_a & 0XFFFFFFFF;
		e = d;
		d = c;
		c = circular_left_shift(b, 30);
		c = c & 0XFFFFFFFF;
		b = a;
		a = temp_a1;
	}
	printf("Round1 -> A: %08llX, B: %08llX, C: %08llX, D: %08llX, E: %08llX\n", a, b, c, d, e);

	for (int t = 20 ; t < 40; t++)//round2
	{
		temp_a = e + F(t, b, c, d) + circular_left_shift(a, 5) + w[t] + K(t);
		temp_a1 = temp_a & 0XFFFFFFFF;
		e = d;
		d = c;		
		c = circular_left_shift(b, 30);
		c = c & 0XFFFFFFFF;
		b = a;
		a = temp_a1;
	}
	printf("Round2 -> A: %08llX, B: %08llX, C: %08llX, D: %08llX, E: %08llX\n", a, b, c, d, e);

	for (int t = 40 ; t < 60 ; t++)//round3
	{
		temp_a = e + F(t, b, c, d) + circular_left_shift(a, 5) + w[t] + K(t);
		temp_a1 = temp_a & 0XFFFFFFFF;
		e = d;
		d = c;		
		c = circular_left_shift(b, 30);
		c = c & 0XFFFFFFFF;
		b = a;
		a = temp_a1;
	}
	printf("Round3 -> A: %08llX, B: %08llX, C: %08llX, D: %08llX, E: %08llX\n", a, b, c, d, e);

	for (int t = 60; t < 80; t++)//round4
	{
		temp_a = e + F(t, b, c, d) + circular_left_shift(a, 5) + w[t] + K(t);
		temp_a1 = temp_a & 0XFFFFFFFF;
		e = d;
		d = c;		
		c = circular_left_shift(b, 30);
		c = c & 0XFFFFFFFF;
		b = a;
		a = temp_a1;
	}
	printf("Round4 -> A: %08llX, B: %08llX, C: %08llX, D: %08llX, E: %08llX\n\n\n", a, b, c, d, e);
	
	A += a;
	A = A & 0XFFFFFFFF;
	B += b;
	B = B & 0XFFFFFFFF;
	C += c;
	C = C & 0XFFFFFFFF;
	D += d;
	D = D & 0XFFFFFFFF;
	E += e;
	E = E & 0XFFFFFFFF;

	printf("<Output 160-bits>\n");
	printf("Result: %llX %llX %llX %llX %llX\n", A, B, C, D, E);

	
	
	return 0;
}

long long string_to_hex(char *input)
{
	long long hex = 0; //16진수 
	for (int i = 0; i < 8; i++)
	{		
		hex = hex << 4; //4bit 이동(16진수라서)
		hex = (input[i] > '9') ? hex+ input[i] - 'A' + 10 : hex + input[i] - '0'; //9 초과(알파벳 문자 'A' 이상인 문자, 'A'를 빼고 10을 더함), 9이하('0'빼기)
	}

	return hex;
}

long long F(long long t, long long b, long long c, long long d)
{

	if (t >= 0 && t < 20)
		x = (b & c) | ((~b) & d);
	else if (t >= 20 && t < 40)
		x = (b ^ c ^ d);
	else if (t >= 40 && t < 60)
		x = ((b & c) | (b & d) | (c & d));
	else if (t >= 60 && t < 80)
		x = (b ^ c ^ d);

	return x;
}

long long K(long long t)
{
	if (t >= 0 && t < 20)
		x = 0x5A827999;
	else if (t >= 20 && t < 40)
		x = 0x6ED9EBA1;
	else if (t >= 40 && t < 60)
		x = 0x8F1BBCDC;
	else if (t >= 60 && t < 80)
		x = 0xCA62C1D6;

	return x;
}

long long circular_left_shift(long long temp, long long num)
{
	x = (temp << num) | (temp >> 32 - num);
	return x;
}
