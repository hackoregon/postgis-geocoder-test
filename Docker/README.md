# Hack Oregon PostGIS Geocoder

## Docker hosting
I develop on a Fedora 25 host using `docker` and `docker-compose` as shipped in Fedora.

```
[znmeb@AlgoCompSynth Docker]$ docker --version
Docker version 1.12.6, build ae7d637/1.12.6
[znmeb@AlgoCompSynth Docker]$ docker-compose --version
docker-compose version 1.9.0, build 2585387
```

I test on Windows 10 Pro using Docker for Windows. This is the Docker package that uses the native Hyper-V virtualizer, *not* the one that uses VirtualBox. If you have another Docker hosting setup make sure it's at least Docker 1.12.6 and docker-compose 1.9.0, and open an issue if anything is broken.
