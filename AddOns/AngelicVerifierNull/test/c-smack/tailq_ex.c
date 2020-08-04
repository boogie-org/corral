/*
 * TAILQ example program.
 */

#include <stdlib.h>
#include <stdio.h>

/*
 * On many OpenBSD/NetBSD/FreeBSD you could include <sys/queue.h>, but
 * for portability we'll include the local copy.
 */
#include <sys/queue.h> 

/*
 * This structure defines each item in our tail queue.  It must also
 * contain an item (TAILQ_ENTRY) that points to the next and previous
 * items in the tail queue.
 *
 * For simplicity, we will be creating a list of integers.
 */
struct tailq_entry {
	int value;

	/*
	 * This holds the pointers to the next and previous entries in
	 * the tail queue.
	 */
	TAILQ_ENTRY(tailq_entry) entries;
};

/*
 * Our tail queue requires a head, this is defined using the
 * TAILQ_HEAD macro.
 */
TAILQ_HEAD(, tailq_entry) my_tailq_head;

int
main(int argc, char **argv)
{
	/* Define a pointer to an item in the tail queue. */
	struct tailq_entry *item;

        /* In some cases we have to track a temporary item. */
        struct tailq_entry *tmp_item;

	int i;

	/* Initialize the tail queue. */
	TAILQ_INIT(&my_tailq_head);

	/* Add 10 items to the tailq queue. */
	for (i = 0; i < 10; i++) {
		/*
		 * Each item we want to add to the tail queue must be
		 * allocated.
		 */
		item = malloc(sizeof(*item));
		if (item == NULL) {
			perror("malloc failed");
			exit(EXIT_FAILURE);
		}

		/* Set the value. */
		item->value = i;

		/*
		 * Add our item to the end of tail queue. The first
		 * argument is a pointer to the head of our tail
		 * queue, the second is the item we want to add, and
		 * the third argument is the name of the struct
		 * variable that points to the next and previous items
		 * in the tail queue.
		 */
		TAILQ_INSERT_TAIL(&my_tailq_head, item, entries);
	}

	/* Traverse the tail queue forward. */
	printf("Forward traversal: ");
	TAILQ_FOREACH(item, &my_tailq_head, entries) {
		printf("%d ", item->value);
	}
	printf("\n");

	/* Insert a new item after the item with value 5. */
	printf("Adding new item after 5: ");
	TAILQ_FOREACH(item, &my_tailq_head, entries) {
		if (item->value == 5) {
			struct tailq_entry *new_item =
			    malloc(sizeof(*new_item));
			if (new_item == NULL) {
				perror("malloc failed");
				exit(EXIT_FAILURE);
			}
			new_item->value = 10;

			TAILQ_INSERT_AFTER(&my_tailq_head, item, new_item,
			    entries);
			break;
		}
	}

        /* Do another forward traversal to show the newly added item. */
	TAILQ_FOREACH(item, &my_tailq_head, entries) {
		printf("%d ", item->value);
	}
	printf("\n");

	/*
         * Delete the item with the value 3.
         *
         * We can't use TAILQ_FOREACH here as TAILQ_FOREACH is not
         * safe against deletions during the traversal.  Some variants
         * of queue.h have TAILQ_FOREACH_MUTABLE or TAILQ_FOREACH_SAFE
         * which are safe against deletions.
         */
	printf("Deleting item with value 3: ");
        for (item = TAILQ_FIRST(&my_tailq_head); item != NULL; item = tmp_item)
        {
		tmp_item = TAILQ_NEXT(item, entries);
		if (item->value == 3) {
			/* Remove the item from the tail queue. */
			TAILQ_REMOVE(&my_tailq_head, item, entries);

			/* Free the item as we don't need it anymore. */
			free(item);

			break;
		}
	}

	/* Another forward traversal to show that the value 3 is now gone. */
	TAILQ_FOREACH(item, &my_tailq_head, entries) {
		printf("%d ", item->value);
	}
	printf("\n");

	/* Free the entire tail queue. */
	while (item = TAILQ_FIRST(&my_tailq_head)) {
		TAILQ_REMOVE(&my_tailq_head, item, entries);
		free(item);
	}

	/* The tail queue should now be empty. */
	if (!TAILQ_EMPTY(&my_tailq_head))
		printf("tail queue is NOT empty!\n");

	return 0;
}
