---
layout: post
title: Easy Email for Debian Sysadmins
date: '2014-07-29 23:41:51'
---

If you have a Debian server, there are different reasons that you might not want
to run a mail server, or you might not even be able to. Setting up postfix or
sendmail can be a complicated, daunting task that not a lot of people have the
time or interest to do. Even if you want to, if you're running your server at
home there's a good chance your ISP blocks outgoing email on port 25. This is a
simple solution for setting up outgoing-only SMTP for your server.

The two things we'll be using to accomplish this are SSMTP and Amazon SES.
Simple SMTP is a mail transfer agent, but all it does is relay your messages to
a real, remote SMTP server. Amazon SES is what we'll use for the actual email
account that sends your emails. You can use a Google account with SSMTP, but
this is against the TOS for most webmail, and generally your address will be
autodetected and banned if you do this. In contrast, SES is designed for
automated bulk email delivery and this is a perfect use case for it.

There are two ways to set up Amazon SES. The more complicated but powerful way
requires you to own your own domain name. You can always pick up a `.info`
domain name for $2.99 at [GoDaddy][godad], at least for the first year, but you
don't need to.

The other option is to verify your own address, and send email to yourself from
SES to your provider. If that sounds a bit confusing, it should become more
clear as we go over the configuration. It will appear as though your email comes
from gmail or yahoo, but it will really originate from SES. It's like a ghost
version of you is emailing yourself. No matter your decision, you'll want to
create an account at the [Amazon Web Services][aws] portal. 

## Domain Name Verification

If you go the domain name route, you can send your email from whichever address
you'd like. You can receive email from "myserver@myhostname.com" and send it to
"my.name@gmail.com", or any other setup you could think of. The following
explains how to set this up, but you can safely skip it if you're not
configuring a custom domain.

With your newly created Amazon account, log in and navigate to the
[SES Management Console][ses]. In the "Domains" section, click "Verify a New
Domain" and enter the domain you own or purchased. Make sure to check "Generate
DKIM Settings", Gmail is a bit happier receiving email when these are set.

The next page will list a `TXT` and three `CNAME` records for your domain. Open
another tab or download these as CSV, and log into your domain registrar's
website. If you purchased a domain from GoDaddy, that's where you'll want to
head. Launch the Domain Manager, find your domain and edit the "DNS Zone
File". This is where you want to add those records that Amazon generated for
you.

After you've done this you might need to wait up to a few hours. DNS propagation
can take awhile (you can speed this up a little by lowering the TTL value), and
then Amazon needs to verify these records before you can continue. When I tested
this it only took about 10 minutes though.

## Single Email Address Verification

On the other hand, if you'd like to forego your own domain you can just verify
your personal email account. Visit the [SES Management Console][ses] and click
the "Email Addresses" section. Assuming you use gmail, click "Verify a New Email
Address" and enter your.address@gmail.com.

The rest is pretty standard, you'll receive an email and just click on the link
to verify you own that address. That's all you need to do.

## Setting up your Server

That's it for verification, and now you can login to your server proper to
finish things up. The first step here is to install the `SSMTP` package.

    sudo apt-get install ssmtp

SSMTP stores its configuration in `/etc/ssmtp/ssmtp.conf`. It takes a couple
fields, and I've listed the configuration you need for Amazon SES. Double check
the mailhub setting, accessible in the [SES Console][ses], as you might be in a
different region than me. For the `AuthUser` and `AuthPass` fields, you need to
click on the "Generate SMTP Settings" button and create an Amazon Identity and
Access Management (IAM) user. It will provide you with proper SMTP credentials.

    root=your.name@gmail.com # Email sent to root is forwarded here
    UseTLS=YES
    mailhub=email-smtp.us-east-1.amazonaws.com:465
    AuthUser=AKIAR6999999AAAAA99999 # You need to generate this for yourself
    AuthPass=As7p8A3asdf3*sdfaasd3D # Same here, these are fake entries.

### Domain Setup

For domain setup, you also need to add a hostname field to `ssmtp.conf`. If
you're doing single address configuration, just skip this section too.
Otherwise, the hostname field you add must match the domain name you verified
for use with SES.

    hostname=bpace.info

At this point your email should be working, and you'll receive email from
useraccount@bpace.info for every user on the system. For example, root email
will arrive separately. coming from root@bpace.info. If you'd like to tweak
this behavior, you can also create `/etc/ssmtp/revaliases` and add something
similar to this:

    root:servername@bpace.info
    pacebl:servername@bpace.info

You don't need the `revaliases` file though, and everything should be working at
this point. The only thing left is to filter away these emails to your heart's
content. 

### Single Address Setup

If you're setting up a single address, you just need to add the `revaliases`
file at `/etc/ssmtp/revaliases` and add the following information.
You can add a label to the verified address, which is the portion after the `+`
and before the `@` symbols below. This is useful for filtering these automated
messages.

    root:your.name+rootbpace@gmail.com
    bpace:your.name+bpace@gmail.com

Even if you don't want to add a label, for each user account you want to receive
email from you need to add a `revaliases` entry pointing to your address. If you
don't, ssmtp will attempt to send mail from addresses such as "root@gmail.com".
SES will just complain you haven't verified these addresses and refuse to
deliver your mail.

After this, everything should be working for single address mode. Enjoy
receiving email from your servers without a real mail server.

[godad]: https://www.godaddy.com/
[aws]:   https://aws.amazon.com/
[ses]:   https://console.aws.amazon.com/ses/


