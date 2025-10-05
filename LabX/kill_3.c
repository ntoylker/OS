#include <stdio.h>
#include <unistd.h>
#include <signal.h>

void handle_signal(int sig) {
    printf("Child received signal %d\n", sig);
}

int main() {
    pid_t pid = fork();
    if (pid == 0) { // Child process
        signal(SIGUSR1, handle_signal);
        pause(); // Wait for signal
    } else { // Parent process
        sleep(1);
        kill(pid, SIGUSR1); // Send signal
    }
    return 0;
}
