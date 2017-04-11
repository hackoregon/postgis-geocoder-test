# Oregon Geocoder as a Docker image
1. You will need:
    * Docker Community Edition (stable): Docker version 17.03.1-ce, build c6d412e or later,
    * docker-compose: docker-compose version 1.11.2, build dfed245 or later, and
    * PostgreSQL 9.6 or greater on your host.
    * Note: I am currently testing on an Ubuntu 16.04.2 LTS "Xenial Xerus" system. I will be testing on Windows 10 Pro / Docker for Windows.
2. Edit the file `env-dockerservice`. Change the `PGPASSWORD` to a strong password of your choosing. Do not check the new password into version control!
3. Open a command prompt in this directory and type `docker-compose up --build`. It will take a while to restore the database. You can ignore errors and warnings.
4. When the service is ready you'll see something like

    ```
    postgis_1  | PostgreSQL init process complete; ready for start up.
    postgis_1  | 
    postgis_1  | LOG:  database system was shut down at 2017-04-10 23:49:54 UTC
    postgis_1  | LOG:  MultiXact member wraparound protections are now enabled
    postgis_1  | LOG:  database system is ready to accept connections
    postgis_1  | LOG:  autovacuum launcher started
    ```

    When that message appears, type `CTRL-C` to stop the service. The container is now ready for re-use.
5. To start the service back up again, type `docker-compose up -d`. The container will start up again and you'll be able to connect as `postgres` on host `localhost` port `5439` with the password you set above. Note that the port is ***5439*** to avoid conflicts with your host PostgreSQL service.
6. Type `test-geocoder.bash` (on a Linux host, anyway - need a Windows version) and if everything is working you'll see the Hack Oregon headquarters geocoded.
7. When you're done, type `docker-compose stop` to shut down the service. The container and its image will preserve data even over a reboot.
8. To restart, just type `docker-compose up -d` again.
9. If you need to rebuild, for example, if the geocoder database dump changes, type `docker-compose down`. This will destroy the container and release the image. `docker-compose up --build` again to rebuild it.
