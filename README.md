vmxor
=====

vmxor creates "pristine" virtual machines on Mac OS X with VMWare Fusion.

Features:
* no dependencies other than VMWare Fusion and Mac OS X 
* VM creation is determined solely from text files and official Linux distro DVD .iso files
* `vmxor-make` and `vmxor-dhcp` are just simple Perl scripts, roughly 100 lines each
* only a trivial amount of manual interaction required

As of this writing I am using vmxor with VMWare Fusion Professional 7.1 on Mac
OS X 10.10 to create CentOS 7 virtual machines. In the past I've used vmxor to
create Ubuntu 14.04 LTS, openSUSE and SUSE Linux Enterprise virtual machines.

The example below is roughly what I do to create CentOS 7 VMs, using only these inputs:
* official CentOS-7-x86_64-DVD-1511.iso file
* `ks.cfg` text file (45-ish lines)
* `default.vmx.template` text file (60-ish lines)


Example Usage
-------------

### Run these commands once to setup your Mac for this example

```
export PATH=$PATH:/Applications/VMware\ Fusion.app/Contents/Library/
ln -s /where/you/put/DVD/iso/files/ ~/.vmxor-dvds
cd ~/.vmxor-dvds
curl -C - -L -O http://centos.mirror.constant.com/7/isos/x86_64/CentOS-7-x86_64-DVD-1511.iso
cd location/of/this/source/code/
./vmxor-dhcp myvm 10-99
sudo stage/commit.sh
```

### To create a VM named `myvm10` just do

```
cd location/of/this/source/code/examples/
./vmxor-make-centos myvm10
```

You will be instructed to enter `linux ks=hd:fd0` to start automated CentOS 7
installation.

That's it! You will have a minimal CentOS 7 virtual server created and
running. From Terminal do `ssh root@myvm10` and use password `changeme`.


History
-------

I wrote vmxor before [Vagrant](http://www.vagrantup.com) worked with VMWare
Fusion. If you want to work on anything other than VMWare on Mac OS X then you
should consider Vagrant or other alternatives. I have not used Vagrant but I'm
sure it has way more features. On the other hand, it will probably be easier to
understand and customize vmxor.

A private earlier version of vmxor ran on Fusion 3 on Mac OS X 10.6 and
probably still works with this earlier version with possibly only one minor
tweak.


Advanced Usage
--------------

### Fusion Shared Folders

Compare `default.vmx.template` to `examples/sharedfolder.vmx.template` to see
an example of a shared folder automatically added to a virtual machine. To use
this non-default ".vmx.template" file, use the `--vmxin` argument of `vmxor-make`.

When configuring a new virtual machine with a shared folder, you will want to do
something like the following from script:

```
echo .host:/shr /home/linuxuser/shr vmhgfs defaults 0 0 >> /etc/fstab
service vmtoolsd start
mount --all -t vmhgfs
```

At one point I found VMWare shared folders (vmhgfs) to work more reliably and
more easily than NFS. But then Linux kernel updates and vmhgfs driver issues
caused upgrade head-aches. I've since switched back to using NFS and not had
any problems since.


### Enhancing .vmx.template files

One way to make an enhanced .vmx.template file is to find the .vmx file of an
existing VM and simply diff it with `default.vmx.template`. You'll get an idea
of what lines to add. Normally .vmx files are inside the subdirectories in
`~/Documents/Virtual Machines.localized`.



Enjoy,

Castedo Ellerman <castedo@castedo.com>

