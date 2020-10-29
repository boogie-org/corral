#include <stdio.h>
#include <stdlib.h>
#include "sys_queue_listop.h"

LIST_HEAD( sample_list, sample_entry );
struct sample_entry{
	int	data;
	LIST_ENTRY(sample_entry) list;
};

static inline struct sample_entry *list_put( struct sample_list *head, int input )
{
	struct sample_entry *new_node = calloc( 1, sizeof( struct sample_entry ) );
	new_node->data = input;
	LIST_INSERT_HEAD( head, new_node, list );
	return new_node;
}

static inline int smpl_cmp( struct sample_entry* a, struct sample_entry *b ){
	return a->data - b->data;
}

static inline void smpl_print( struct sample_entry* a ){
	printf("%d", a->data);
}

int main(void){
	struct sample_list 		head;
	struct sample_entry 	*result_node;

	LIST_INIT( &head );

	list_put( &head, 1 ); list_put( &head, 2 ); list_put( &head, 3 );
	list_put( &head, 4 ); list_put( &head, 5 ); list_put( &head, 6 );

	LIST_PRINT( &head, struct sample_entry, list, smpl_print );

	LIST_EXISTS( &head, struct sample_entry, list, data, 3, result_node );
	if( result_node ){
		printf( "\n 3 exists. Delete the entry. \n" );
		LIST_DEL( &head, result_node, list );
		LIST_PRINT( &head, struct sample_entry, list, smpl_print );
	}

	LIST_EXISTS( &head, struct sample_entry, list, data, 3, result_node );
	if( result_node ){
		printf( "\n 3 exists. Delete the entry \n" );
		LIST_DEL( &head, result_node, list );
		LIST_PRINT( &head, struct sample_entry, list, smpl_print );
	}

	LIST_SORT( &head, struct sample_entry, list, smpl_cmp );
	
	LIST_PRINT( &head, struct sample_entry, list, smpl_print );

	LIST_CLEAR( &head, struct sample_entry, list );

	LIST_PRINT( &head, struct sample_entry, list, smpl_print );

	return 0;
}
