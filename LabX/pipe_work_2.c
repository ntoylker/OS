#include <stdio.h>
#include <unistd.h>
#include <string.h>

int main() {
    int pipefd[2];
    char buffer[100];
    pipe(pipefd);

    if (fork() == 0) { // Child process
        close(pipefd[1]); // Close write end
        read(pipefd[0], buffer, sizeof(buffer));
        printf("Child received: %s\n", buffer);
        close(pipefd[0]);
    } else { // Parent process
        close(pipefd[0]); // Close read end
        char message[] = "Hello from parent!";
        write(pipefd[1], message, strlen(message) + 1);
        close(pipefd[1]);
    }
    return 0;
}
