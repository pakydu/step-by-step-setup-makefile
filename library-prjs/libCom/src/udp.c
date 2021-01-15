#include <comlib.h>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>

int CreateUdpSock(int * pnSock, int nPort)
{
	struct sockaddr_in addrin;
	struct sockaddr *paddr = (struct sockaddr *)&addrin;

	ASSERT(pnSock != NULL && nPort > 0);
	memset(&addrin, 0, sizeof(addrin));
	/* Э���ַ��� */
	addrin.sin_family = AF_INET;			/* Э���� */
	addrin.sin_addr.s_addr = htonl(INADDR_ANY);	/* �Զ������ַ */
	addrin.sin_port = htons(nPort);			/* �˿ں� */
	/* ��װϵͳ����socket��bind */
	ASSERT((*pnSock = socket(AF_INET, SOCK_DGRAM, 0)) > 0);	/* ����UDP�׽��������� */
	if (VERIFY(bind(*pnSock, paddr, sizeof(addrin)) >= 0) )	/* �����׽��� */
		return 0;					/* ׼���ɹ�����ȷ���� */
	VERIFY(close(*pnSock) == 0);				/* ׼��ʧ�ܣ��ر��׽��������� */
	return 1;
}


int SendMsgByUdp(void * pMsg, int nSize, char * szAddr, int nPort)
{
	int nSock;
	struct sockaddr_in addrin;
    	ASSERT((nSock = socket(AF_INET, SOCK_DGRAM, 0)) > 0);	/* ����UDP�׽��������� */
	memset(&addrin, 0, sizeof(struct sockaddr));
	/* ���շ���Э���ַ��� */
	addrin.sin_family = AF_INET;			/* Э���� */
	addrin.sin_addr.s_addr = inet_addr(szAddr);	/* ���շ��ĵ�ַ */
	addrin.sin_port = htons(nPort);			/* ���շ��ķ���˿ں� */
	VERIFY(sendto(nSock, pMsg, nSize, 0,		/* �������ݵ����շ� */
	             (struct sockaddr *)&addrin,
	             sizeof(addrin)) > 0);
	close (nSock);					/* �ر��׽��� */
	return 0;
}
		
int RecvMsgByUdp(int nFile, void * pData, int * pnSize) 
{
	/* �������ݣ��������ķ��ͷ�Э���ַ */
	ASSERT((*pnSize=recvfrom(nFile, pData, *pnSize, 0 , NULL, NULL)) > 0);
	return 0;
}

