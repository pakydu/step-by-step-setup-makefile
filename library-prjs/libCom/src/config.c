#include <comlib.h>

int GetConfigStrValue(char *buf, void *pValue, int nType)
{
	char *nCeAddr[2];
	int nCeLen[2];
	STRRESVAR stuStr;
	stuStr.nAmount = 2;				/* ���������� */
	stuStr.nFlag = 1;				/* �̶��ָ� */
	stuStr.filedlen = nCeLen;		/* ÿ����ĳ��� */
	stuStr.nCompartlen = 1;			/* �ָ����ŵĳ��� */
	strcpy(stuStr.szCompart, "=");	/* �ָ��ַ��� */
	stuStr.filedaddr = nCeAddr;		/* ָ��ÿ�����׵�ָ�� */
	strrespre(buf, &stuStr);		/* �����ַ������� */
	ASSERT(strresvalue(buf, stuStr, 1, pValue, nType) == 0);
	return 0;	
}

int GetConfigValue(char *szPath, char *szRoot, char *szName, void *pValue, int nType)
{
	FILE *fp;
	int nFlag = 0;							/* ����������ı�־ */
	char buf[1024], szRootExt[100], szNameExt[100];
	ASSERT( (fp = fopen(szPath, "r")) != NULL);
	sprintf(szRootExt, "[%s]", szRoot);	/* ������[szRoot]����ʽ */
	sprintf(szNameExt, "%s=", szName);		/* �����szName=����ʽ */
	while (feof(fp) == 0)					
	{
		memset(buf, 0, sizeof(buf));
		char *pTmp = fgets(buf, sizeof(buf), fp);		/* ��ȡ�ļ��е�ÿһ���ַ��� */
		if (pTmp != NULL)
		{
			if (buf[0] == '#') continue;		/* ע���У����� */
												/* δ����������ʱ��ֻ��ѯ�������� */
			if (nFlag == 0 && buf[0] != '[') continue;
												/* δ���������򣬵�ǰ������������ */
			else if (nFlag == 0 && buf[0] == '[') 
			{									/* ƥ�䵱ǰ�������Ƿ�Ϊ������ */
				if (strncmp(buf, szRootExt, strlen(szRootExt)) == 0) nFlag = 1;
			}
			else if (nFlag == 1 && buf[0] == '[')
			{									
				break;							/* ������������ */
			}
			else 								/* �����������е������� */
			{									/* ƥ�䵱ǰ�������Ƿ�Ϊ������ */
				if (strncmp(buf, szNameExt, strlen(szNameExt)) == 0)
				{								/* ���������зֽ�����ȡֵ */
					ASSERT(GetConfigStrValue(buf, pValue, nType) == 0);
					fclose(fp);
					return 0;
				}
			}
		}
	}
	fclose(fp);
	return -1;
}

