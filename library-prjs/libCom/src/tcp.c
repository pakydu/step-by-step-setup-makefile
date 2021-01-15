#include <comlib.h>
#include <unistd.h>

int CreateSock(int* pSock, int nPort, int nMax)
{
	struct sockaddr_in addrin;
	struct sockaddr *paddr = (struct sockaddr *)&addrin;

	ASSERT(pSock != NULL && nPort > 0 && nMax > 0);
	
	memset(&addrin, 0, sizeof(addrin));
	/* Э���ַ��� */
	addrin.sin_family = AF_INET;			/* Э���� */
	addrin.sin_addr.s_addr = htonl(INADDR_ANY);	/* �Զ������ַ */
	addrin.sin_port = htons(nPort);			/* �˿ں� */
	ASSERT((*pSock = socket(AF_INET, SOCK_STREAM, 0)) > 0);	/* ����TCP�׽��������� */
	if (VERIFY(bind(*pSock, paddr, sizeof(addrin)) >= 0) &&	/* �����׽��� */
	    VERIFY(listen(*pSock, nMax) >= 0))		/* �׽��ֽ�������״̬ */
		return 0;				/* ׼���ɹ�����ȷ���� */
	VERIFY(close(*pSock) == 0);			/* ׼��ʧ�ܣ��ر��׽��������� */
	return 1;
}

int AcceptSock(int * pSock, int nSock)
{
	struct sockaddr_in addrin;
	int lSize;
	ASSERT(pSock != NULL && nSock > 0);
	while (1)
	{
		lSize = sizeof(addrin);
		memset(&addrin, 0, sizeof(addrin));
		/* �������տͻ����������󣬲������µ��׽��������� */
		if ((*pSock = accept(nSock, (struct sockaddr *)&addrin, &lSize)) > 0)
			return 0;
		/* ����accept�����н��յ����źţ������ж� */
		else if (errno == EINTR)	continue;
		else  	ASSERT(0);
	}
}

int ConnectSock(int *pSock, int nPort, char * pAddr)
{
	struct sockaddr_in addrin;
	long lAddr;
	int nSock;
	
	ASSERT(pSock != NULL && nPort > 0 && pAddr != NULL);
	ASSERT((nSock = socket(AF_INET, SOCK_STREAM, 0)) > 0);	/* ����TCP�׽��������� */
	/* Э���ַ��� */
	memset(&addrin, 0, sizeof(addrin));
	addrin.sin_family = AF_INET;			/* Э���ַ���� */
	addrin.sin_addr.s_addr = inet_addr(pAddr);	/* �ַ���IP��ַת��Ϊ�����ֽ�˳�� */
	addrin.sin_port = htons(nPort);			/* �˿ں�ת�����ֽ�˳�� */
	if (VERIFY(connect(nSock, (struct sockaddr *)&addrin, sizeof(addrin)) >= 0))
	{	/* ���ӳɹ��������׽��������� */
		*pSock = nSock;
		return 0;
	}
	/* ����ʧ�ܣ��ر��׽��������� */
	close(nSock);
	return 1;
}


int LocateRemoteAddr(int nSock, char *pAddr)
{
	struct sockaddr_in addrin;
	int lSize;
	ASSERT(nSock > 0 && pAddr != NULL);
	memset(&addrin, 0, sizeof(addrin));
	lSize = sizeof(addrin);
	ASSERT(getpeername(nSock, (struct sockaddr*)&addrin, &lSize) >= 0);	/* ��ȡ�Է��׽���Э���ַ��Ϣ */
	strcpy(pAddr, (char *)inet_ntoa(addrin.sin_addr));		/* ת���׽��ֵ�ַ��ϢΪ�Ե�ָ����ַ�����ʽ */
	return 0;
}

int LocateNativeAddr(int nSock, char *pAddr)
{
	struct sockaddr_in addrin;
	int lSize;
	ASSERT(nSock > 0 && pAddr != NULL);
	memset(&addrin, 0, sizeof(addrin));
	lSize = sizeof(addrin);
	ASSERT(getsockname(nSock, (struct sockaddr*)&addrin, &lSize) >= 0);	/* ��ȡ���������׽���Э���ַ��Ϣ */
	strcpy(pAddr, (char *)inet_ntoa(addrin.sin_addr));		/* ת���׽��ֵ�ַ��ϢΪ�Ե�ָ����ַ�����ʽ */
	return 0;
}

