#include <comlib.h>
#include <unistd.h>

int ReadFile(int nFile, void * pData, int * pSize)
{
	int nLeft, nRead;
	char *pcData = pData;	
	ASSERT(pData != NULL && pSize != NULL);
	nLeft = *pSize;
	while (nLeft > 0)
	{
		if ((nRead = read(nFile, pcData, nLeft)) < 0)
		{
			if (errno != EINTR) ASSERT(0);
			nRead = 0;
		}
		else if (nRead == 0) break;
		nLeft -= nRead;
		pcData += nRead;
	}
	*pSize = *pSize - nLeft;
	return 0;
}

int WriteFile(int nFile, void* pData, int nSize)
{
	int nLeft = nSize, nWrite;
	const char *pcData = pData;
	ASSERT(pData != NULL);
	while (nLeft > 0)
	{
		if ((nWrite = write(nFile, pcData, nLeft)) <= 0)
		{
			if (errno != EINTR) ASSERT(0);
			nWrite = 0;
		}
		nLeft -= nWrite;
		pcData += nWrite;
	}
	return 0;
}

int ReadFileTime(int nFile, void * pData, int * pnSize, int nTimeout)
{
	int nLeft = 0, nRead = 0;
	int nUseTime = 0;
	time_t t1, t2;
	char *pcData;
	int nFlag;
	fd_set fdsRead;
	struct timeval timeval1;
	ASSERT(pData != NULL);
	ASSERT(pnSize != NULL);
	pcData = pData;
	nLeft = *pnSize;
	while (nLeft > 0)
	{
		if (nTimeout != 0) nTimeout -= nUseTime;
		FD_ZERO(&fdsRead);		/* ���ü���ļ����� */
		FD_SET(nFile, &fdsRead);
		timeval1.tv_sec = nTimeout;	/* ���ó�ʱʱ�� */
		timeval1.tv_usec = 0;
		t1 = 0;
		t2 = 0;
		time(&t1);
		nFlag = select(nFile + 1, &fdsRead, NULL, NULL, &timeval1);
		if (nFlag == 0)			/* ��ʱ���˳� */
		{
			*pnSize = *pnSize - nLeft;
			ASSERTEXT(0, 1);
		}
		if (nFlag < 0)
		{
			if (errno != EINTR) ASSERT(0)
			else
			{
				time(&t2);
				nRead = 0;
				nUseTime = t2 - t1;
			}
		}
		else				/*  ������ȡ */ 
		{
			time(&t2);
			nUseTime = t2 - t1;
			if ((nRead = read(nFile, pcData, nLeft)) < 0)	/* ��ȡ */
			{
				if (errno != EINTR)   ASSERT(0);	/* ���ź��ж������ */
				nRead = 0;
			}
			else if (nRead == 0) break;
		}
		nLeft -= nRead;
		pcData += nRead;
	}
	*pnSize = *pnSize - nLeft;
	return 0;
}

int WriteFileTime(int nFile, void * pData, int nSize, int nTimeout)
{
	int nLeft = 0, nWrite = 0;
	int nUseTime = 0;
	const char *pcData;
	int nFlag;
	time_t t1;
	time_t t2;
	fd_set fdsWrite;
	struct timeval timeval1;
	ASSERT(pData != NULL);
	pcData = pData;
	nLeft = nSize;	
	while (nLeft > 0)
	{
		if (nTimeout != 0) nTimeout -= nUseTime;
		FD_ZERO(&fdsWrite);
		FD_SET(nFile, &fdsWrite);
		timeval1.tv_sec = nTimeout;
		timeval1.tv_usec = 0;
		time(&t1);
		nFlag = select(nFile + 1, NULL, &fdsWrite, NULL, &timeval1);
		if (nFlag == 0) 	ASSERTEXT(0, 1);
		if (nFlag < 0)
		{
			if (errno != EINTR) ASSERT(0)
			else
			{
				time(&t2);
				nUseTime = t2 - t1;
				nWrite = 0;
			}
		}
		else
		{
			time(&t2);
			nUseTime = t2 - t1;
			if ((nWrite = write(nFile, pcData, nLeft)) <= 0)
			{
				if (errno != EINTR) ASSERT(0);
				nWrite = 0;
			}
		}
		nLeft -= nWrite;
		pcData += nWrite;
	}
	return 0;
}
