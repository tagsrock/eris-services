# eris-services
Service Definition Files for the Eris Platform. See [here](https://docs.erisindustries.com/documentation/eris-cli/0.11.0/services_specification/) for the services specification vis-a-vis `$ docker run`.

WARNING: Changing any of the `.toml` files in this repo will cause eris-cli tests (`/initialize`) to fail.

Files here are used for testing against toadserver as part of the eris-cli init sequence, and as backup if the toadserver is down.

# Installing

By default eris will install most of these services during the `eris init` process. However should you want to import a service it is easy with:

```bash
eris services import $name $hash
```

This will import the `$hash` from IPFS and save the service into your eris directory under the $name.

For example:

```bash
eris services import eth QmQ1LZYPNG4wSb9dojRicWCmM4gFLTPKFUhFnMTR3GKuA2
```

Will pull the `QmQ1LZYPNG4wSb9dojRicWCmM4gFLTPKFUhFnMTR3GKuA2` hash from ipfs and save it as the `eth` service.

# Current Hashes of Services

see ipfs_hashes.csv
