#ifndef PREESM_H
#define PREESM_H

#define IN
#define OUT


//#define PREESM_VERBOSE
#define PREESM_LOOP_SIZE 3

#define NB_CORES 2

typedef unsigned char uchar;

void produce(int msg_size, unsigned char *prod_output){
	volatile unsigned char i;

	for(i=0; i<msg_size; i++){
		prod_output[i] = i;
	}

}

void consume(int msg_size, unsigned char *cons_input){
	volatile unsigned char i;
	unsigned int sum = 0;

    printf("\n");

	for(i=0; i<msg_size; i++){
		sum += (unsigned int) cons_input[i];
        printf("%d ",cons_input[i]);
	}
    printf("\n");

	printf("End loop, sum: %d\n", sum);

}


#endif