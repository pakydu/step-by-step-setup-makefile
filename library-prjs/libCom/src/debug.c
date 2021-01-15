#include <comlib.h>
#include <stdarg.h>
#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>

int PrintLog(FILE* pfile, const char * pformat, ...)
{
	va_list _va_list;
	TIMESTRU timestru;
	char szBuf[MAXBUF];
	int nLen;
	if (pformat == NULL || pfile == NULL) return -1; 	/* �ж�ָ���Ƿ���ȷ*/
	timestru = GetTime();
	nLen = sprintf(szBuf, " %04d.%02d.%02d %02d:%02d:%02d [%d]: ",
		timestru.nYear, timestru.nMon, timestru.nDay,
		timestru.nHour, timestru.nMin, timestru.nSec, getpid());
		
	va_start(_va_list, pformat); 				/* ��ʼ���䳤�����б� */
	nLen += vsprintf(szBuf+nLen, pformat, _va_list); 	/* ���ݱ䳤���� */
	va_end(_va_list); 					/* ����ʹ�ñ䳤�����б� */
	
	nLen += sprintf(szBuf + nLen, "\n");			/* ���ӻ��з� */
	if (fputs(szBuf, pfile) != EOF && fflush(pfile) != EOF) return 0;/*  �����ˢ���ļ��� */
	return -2;						/* ���󷵻� */
}

int PrintTraceLog(const char* pformat, ...)
{
 	va_list _va_list;
	char szBuf[MAXBUF];
 	FILE *fp;
 	int ret;
	if (pformat == NULL) return -1; 	/* �ж�ָ���Ƿ���ȷ*/
		
 	va_start(_va_list, pformat);		  
 	vsprintf(szBuf, pformat, _va_list);     
 	va_end(_va_list);                      

 	if ((fp = fopen(TRACE_FILE, "a")) != NULL)
 	{
 		ret = PrintLog(fp, szBuf);	/* д��־�ļ� */
 		fclose(fp);			/* �ر���־�ļ� */
	 	return(ret);
 	}
 	return -1;
}

int PrintHexLog(FILE* pfile, void * pData, int nSize)
{
	char cLine[16], *pcData;
	char szBuf[MAXBUF + 1];
	int nPos, nLineSize, nLine, nLen, n;
	if (pfile == NULL || pData == NULL) return -1;
	
	pcData = (char*)pData;
	nLine = 1;
	nLen = sprintf(szBuf, "address[%08X] size[%d]\n", pData, nSize);
	for (nPos = 0; nPos < nSize; nLine++)
	{
		nLineSize = min(nSize - nPos, 16);		/* ��ֹ���һ�����ݲ��� */
		memcpy(cLine, pcData + nPos, nLineSize);
		nPos += nLineSize;
		nLen += sprintf(szBuf + nLen, "[%02d]:  ", nLine);
		for (n = 0; n < nLineSize; n++)
		{
			if (n == 8) nLen += sprintf(szBuf + nLen, " ");/* ��8���ֽں�ո� */
			nLen += sprintf(szBuf + nLen, "%02X ", cLine[n] & 0x00FF);
		}
		for (n = nLineSize; n < 16; n++)	/* ���һ�в��ո� */
		{
			if (n == 8) nLen += sprintf(szBuf + nLen, " ");
			nLen += sprintf(szBuf + nLen, "   ");
		}
		nLen += sprintf(szBuf + nLen, " :");
		for (n = 0; n < nLineSize; n++)		/* ���ַ���ʾ�ڴ����� */
		{
			if (!isprint(cLine[n])) cLine[n] = '.';	/* �ԡ�.����ʾ�Ǵ�ӡ�ַ� */
			nLen += sprintf(szBuf + nLen, "%c", cLine[n]);
		}
		nLen += sprintf(szBuf + nLen, "\n");
	}
	PrintLog(pfile, szBuf);
	return 0;
}

int PrintTraceHexLog(void * pData, int nSize)
{
 	FILE *fp;
 	int ret;
 	if ((fp = fopen(TRACE_FILE, "a")) != NULL)
 	{
 		ret = PrintHexLog(fp, pData, nSize);	/* д��־�ļ� */
 		fclose(fp);				/* �ر���־�ļ� */
	 	return(ret);
 	}
 	return -1;
}

int Verify(int bStatus, const char* szBuf, const char* szFile, int nLine)
{
	FILE *fp;
	char szFileLine[128], szError[128];
	if (!bStatus)
	{
		memset(szFileLine, 0, sizeof(szFileLine));       
		memset(szError, 0, sizeof(szError));
		if (errno != 0) sprintf(szError, "\t> %-64s\n", strerror(errno));
		if (szFile == NULL) strcpy(szFileLine, "\t> Invalid file name");
		else sprintf(szFileLine, "\t> In line %d file %-32s", nLine, szFile);
		if (szBuf == NULL)  szBuf = "";
		fp = fopen(TRACE_FILE, "a");
		if (fp != NULL)
		{
			PrintLog(fp, "%s[%d]\n%s%s", szBuf, getpid(), szError, szFileLine);
			fclose(fp);
		}
		errno = 0;
	}
	return bStatus;
}
