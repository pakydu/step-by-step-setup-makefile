#include <comlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <sys/stat.h>
#include <unistd.h>
#include <signal.h>

void SigChild(int nSignal)
{
	pid_t pid_t;
	int nState;
	while ((pid_t = waitpid(-1, &nState, WNOHANG)) > 0) ;
	signal(SIGCLD, SigChild);
}
int InitServer()
{
	pid_t pid1;
	ASSERT((pid1 = fork()) >= 0);	/* �����ӽ��� */
	if (pid1 != 0)					/* ������ʧ���˳����ӽ����й� */
	{
		sleep(1);
		exit(0);
	}
	ASSERT(setsid() >= 0);			/* �ӽ��������ն� */
	umask(0);						/* ����ļ��������� */
	signal(SIGINT, SIG_IGN);		/* ����SIGINT�ź� */
	signal(SIGCLD, SigChild);		/* ����SIGCLD�źţ�Ԥ���������� */
	return 0;
}
