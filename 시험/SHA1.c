void SHA_1(FILE* fptr, BYTE* result) 
{
	int i, size = 0;
	BYTE msg[HASH_BLOCK * 2] = { 0, };
	UINT64 f_size = 0; SHA_1_init(); 
	while ((size = fread(msg, sizeof(BYTE), HASH_BLOCK, fptr)))
	{
		f_size += size;
		
		if (size < HASH_BLOCK) 
			padding(msg, f_size);
		SHA_1_digest(msg); 
		if (isAddpad) 
			SHA_1_digest(msg + HASH_BLOCK);
		memset(msg, 0, HASH_BLOCK * 2); 
	} 
	for (i = 0; i < HASH_DATA; i++) 
		result[i] = digest[i]; 
} 
void padding(BYTE* in, UINT64 msg_len)
{
	int i; BYTE* ptr = (BYTE*)&msg_len; 
	in[msg_len % HASH_BLOCK] = 0x80;
	msg_len *= 8; // 메시지가 448비트 보다 작은 경우와 448비트 보다 큰 경우로 나누어 처리 // 448비트보다 큰 경우에는 512비트의 블록을 추가하여 패딩을 수행한다 
	
	if ((msg_len % HASH_BLOCK) < 56) 
	{
		for (i = 0; i<8; i++) in[HASH_BLOCK - i - 1] = *(ptr + i);
	}
	else 
	{
		isAddpad = 1;
		for (i = 0; i<8; i++) 
			in[HASH_BLOCK * 2 - i - 1] = *(ptr + i); 
	}
}



void SHA_1_digest(BYTE* in) 
{
	int i;
	UINT M[16] = { 0, };
	UINT W[80] = { 0, };
	UINT reg[5] = { 0, };
	UINT temp;
	reg[0] = init_reg[0];
	reg[1] = init_reg[1]; 
	reg[2] = init_reg[2]; 
	reg[3] = init_reg[3]; 
	reg[4] = init_reg[4];

	for (i = 0; i < 64; i += 4) 
	{
		M[i / 4] = BTOW(in[i], in[i + 1], in[i + 2], in[i + 3]);
	} 


	for (i = 0; i < 80; i++)
	{ 
		if (i < 16)
			W[i] = M[i];
	
		else W[i] = CIR_SHIFT((W[i - 16] ^ W[i - 14] ^ W[i - 8] ^ W[i - 3]), 1); 
	}
	
	for (i = 0; i < 80; i++) 
	{
		if (i < 20) 
		{
			temp = CIR_SHIFT(reg[0], 5) + F1(reg[1], reg[2], reg[3]) + reg[4] + W[i] + K0;
		} 
		else if (i < 40) 
		{
			temp = CIR_SHIFT(reg[0], 5) + F2(reg[1], reg[2], reg[3]) + reg[4] + W[i] + K1;
		} 
		else if (i < 60)
		{ 
			temp = CIR_SHIFT(reg[0], 5) + F3(reg[1], reg[2], reg[3]) + reg[4] + W[i] + K2;
		} 
		else 
		{ 
			temp = CIR_SHIFT(reg[0], 5) + F2(reg[1], reg[2], reg[3]) + reg[4] + W[i] + K3; 
		}

		reg[4] = reg[3]; reg[3] = reg[2]; reg[2] = CIR_SHIFT(reg[1], 30);
		reg[1] = reg[0]; reg[0] = temp; 
	}
	
	init_reg[0] += reg[0]; init_reg[1] += reg[1];
	init_reg[2] += reg[2]; init_reg[3] += reg[3]; init_reg[4] += reg[4]; 

	make_Bit160(init_reg[0], init_reg[1], init_reg[2], init_reg[3], init_reg[4]); 
}