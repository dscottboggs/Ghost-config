<div style="text-align: center;" markdown="1">
<h1>Ghost</h1>
A lightweight blogging platform
</div>

---

Ghost provides a minimal web interface for writing blog posts using markdown for
formatting, and a standard relational database to store the files. In this
deployment, we place ghost inside of a docker container, with only its *content*
folder kept persistent between launches.

A MariaDB container is included, and the frontend container and the database are
connected by the network "default", which is unique to this application only,
allowing the database and the blog to communicate privately. The database also
has its storage directory mounted in the mounts folder for persistence. Any data
outside of mounted volumes is destroyed between application launches.

The frontend container and the database container are configured through the use
of environment variables. Sensitive variables are stored in files with the
extension ".pw.env", non-sensitive ones are stored directly in the
docker-compose.yml file. Thanks to docker's internal DNS server, we can simply
tell the ghost container to use the database container's name as its network
address.

Finally, we configure the labels that allow Traefik to route requests to the
ghost application. Our frontend container is connected to the "web" network,
which is the one that traefik is connected to. It receives a custom domain and a
rule that requests coming in on that domain should be forwarded to this
container, on port **2368**, which is the one that ghost listens on. This means that
a user can make a request to https://blog.tams.tech, and the request will be
forwarded to the ghost container over plain HTTP on port 2368.

Happy blogging!
