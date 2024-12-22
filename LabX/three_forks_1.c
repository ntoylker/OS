#include <stdio.h>
#include <unistd.h>

int main() {
    for (int i = 0; i < 3; i++) {
        pid_t pid = fork();
        if (pid == 0) { // Child process
            printf("Child process PID: %d\n", getpid());
        } else if (pid > 0) { // Parent process
            printf("Parent process PID: %d\n", getpid());
        } else { // Error
            perror("fork failed");
        }
    }
    return 0;
}
