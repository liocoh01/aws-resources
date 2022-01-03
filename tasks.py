from invoke import task

@task()
def test(ctx):
        with ctx.cd("terraform/"):
            ctx.run("terraform init")
            ctx.run("terraform init -force-copy")
            ctx.run("terraform validate")


@task()
def plan(ctx):
        with ctx.cd("terraform/"):
            ctx.run("terraform plan  -no-color -out=terraform.plan")

@task()
def apply(ctx):
            with ctx.cd("terraform/"):
                ctx.run("terraform apply terraform.plan")





