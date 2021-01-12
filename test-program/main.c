#include <stdlib.h>
#include <stdio.h>

#include "command.h"
#include "display.h"
#include "insert.h"
#include "kdb.h"
#include "utils.h"


int main()
{
    test_command();
    test_display();
    test_insert();
    test_kdb();
    test_utils();
}