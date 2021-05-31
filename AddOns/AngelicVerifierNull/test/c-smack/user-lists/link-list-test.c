#include <stdio.h>
#include <assert.h>
#include <stdlib.h>
#include "list.h"

struct foo {
	int info;
	struct list_head list_member;
};

void add_node(int arg, struct list_head *head)
{
    struct foo *fooPtr = (struct foo *)malloc(sizeof(struct foo));
    assert(fooPtr != NULL);
    
    fooPtr->info = arg;
    INIT_LIST_HEAD(&fooPtr->list_member);
    list_add(&fooPtr->list_member, head);
}

void display(struct list_head *head)
{
    struct list_head *iter;
    struct foo *objPtr;

    __list_for_each(iter, head) {
        objPtr = list_entry(iter, struct foo, list_member);
        printf("%d ", objPtr->info);
    }
    printf("\n");
}

void delete_all(struct list_head *head)
{
    struct list_head *iter;
    struct foo *objPtr;
    
  redo:
    __list_for_each(iter, head) {
        objPtr = list_entry(iter, struct foo, list_member);
        list_del(&objPtr->list_member);
        free(objPtr);
        goto redo;
    }
}

int find_first_and_delete(int arg, struct list_head *head)
{
    struct list_head *iter;
    struct foo *objPtr;

    __list_for_each(iter, head) {
        objPtr = list_entry(iter, struct foo, list_member);
        if(objPtr->info == arg) {
            list_del(&objPtr->list_member);
            free(objPtr);
            return 1;
        }
    }

    return 0;
}

main() 
{
    LIST_HEAD(fooHead);
    LIST_HEAD(barHead);
    
    add_node(10, &fooHead);
    add_node(20, &fooHead);
    add_node(25, &fooHead);
    add_node(30, &fooHead);
    
    display(&fooHead);
    find_first_and_delete(20, &fooHead);
    display(&fooHead);
    delete_all(&fooHead);
    display(&fooHead);
}
