# Publishing

This guide is all about how to put your data online using the DataHub.

# Quickstart

As a new user you want to know quickly how to get going so that you can get your data online as soon as possible.

To put your data online you use our `data` command line tool:

1. How do you get the `data` tool? => follow the [installation instructions][install]
2. How do you use the `data` tool? => Run [`data login` (if your first time) then `data push`][cli-push]

In summary:

<div class="mermaid">
graph TD                                                                                 
client[Get the `data` tool]
login[Login - on the command line]
push[Push data using `data` tool]

client --> login
login --> push
</div>

**Desktop app**: we are  planning a Desktop app as well as the command line tool. If you're interested [let us know][contact].

**API access**: you can push via an API. However, the process is not yet well documented -- so if you want to use it [let us know and we can walk you through it][contact].

[contact]: /contact/
[install]: /publishers/cli/#installation
[cli-push]: /publishers/cli/#push

