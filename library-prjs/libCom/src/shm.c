#include <comlib.h>
#include <sys/shm.h>
#include <setjmp.h>

int CreateMemo(int shmid, int index, int size)
{
	char *pc;
	int *pd;
	if ((pc = shmat(shmid, NULL, 0)) == NULL) return -1;
	pd = (int *) pc;
	pd[0] = index;		/* �����ڴ����������ֵļ�¼���� */
	pd[1] = 0;		/* ��ǰ�Ѿ�ʹ�õļ�¼���� */
	pd[2] = 0;		/* ���һ�η���ļ�¼��� */
	pd[3] = size;		/* ÿ����¼��ĳ��� */
	memset(pc+sizeof(int)*4, 0, size);	/* ����MAP�� */
	shmdt(pc);
	return 0;	
}

int AllocMemoExt(char *pc, int *index)
{
	int nSize, nUsed, nOff, i;
	int *pd = (int *)pc;
	nSize = pd[0];			/* ��¼���� */
	nUsed = pd[1];			/* �ѷ����� */
	nOff = pd[2];			/* ���������� */
	if (nUsed >= nSize) return -1;
	pc = pc + sizeof(int)*4;	/* MAP�� */
	for (i=0; i<nSize; i++)		/* ��nOff�����ҿ��м�¼ */
	{
		if ((pc[nOff] & 0xff) == 0) break;
		nOff = (nOff+1) % nSize;
	}
	if (i >=  nSize)  return -2;
	pc[nOff] = 1;			/* ���ļ�¼���б�� */
	pd[1]++;			/* �ѷ�������1 */
	pd[2] = nOff;			/* ��������¼��� */
	*index = nOff;
	return(0);
}

int AllocMemo(int shmid, int semid, int semindex, int *index)
{
	char *paddr;
	int ret;
	if ((paddr = shmat(shmid, NULL, 0)) == NULL) return -2;
	if (SEMP(semid, semindex) != 0)		/* �ź�P������������������ڴ���Դ */
	{
		shmdt(paddr);
		return -3;
	}
	ret = AllocMemoExt(paddr, index);	/* �����¼ */
	SEMV(semid, semindex);			/* �ź�V�������ͷŲ��������ڴ���Դ */
	shmdt(paddr);				/* ȡ�������ڴ�ӳ�� */
	return(ret);
}

int FreeMemo(int shmid, int semid, int semindex, int index)
{
	char *paddr, *pc;
	int *pd;
	if ((paddr = shmat(shmid, NULL, 0)) == NULL) return -2;
	if (SEMP(semid, semindex) != 0)		/* �ź�P������������������ڴ���Դ */
 	{
		shmdt(paddr);
		return -3;
	}
	pd = (int *)paddr;
	pc = paddr + sizeof(int)*4;			/* MAP���׵�ַ */
	if (index >=0  && index < pd[0])
	{						/* �ͷż�¼ */
		pc[index] = 0;				/* ���ļ�¼���б�� */
		pd[1]--;				/* �ѷ�������1 */
	}
	SEMV(semid, semindex);			/* �ź�V�������ͷŲ��������ڴ���Դ */
	shmdt(paddr);				/* ȡ�������ڴ�ӳ�� */
	return(0);
}

char *GetMemoAddr(char *paddr, int index)
{
	int *pd = (int *)paddr;
	if (index < 0 || index >= pd[0]) return NULL;
	return (paddr + 
		sizeof(int)*4 + 		/* ��Ϣ����4������ */
		pd[0]* sizeof(char) + 		/* MAP����pd[0]���ֽ� */
		pd[3] * index); 		/* ��������ÿ����¼pd[3]�ֽ� */
}
