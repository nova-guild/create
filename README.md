# nova/create

***A project scaffolding CLI for the Nova web framework. Run a single command and get a fully structured Nova project.***

## Overview

`nova/create` generates a Nova project boilerplate tailored to your choice of Luau runtime. It supports all three major standalone Luau runtimes:

- **Lune**
- **Zune**
- **Lute**

Each generated project also ships with a **Dockerfile**, so your Nova app can be hosted on any Docker-compatible platform such as [Render](https://render.com), regardless of the underlying Luau runtime.

## Requirements

- [pesde](https://github.com/pesde-pkg/pesde)

## Usage

Run the following command using pesde's executor:

```bash
# Scaffold into the current directory
pesde x nova/create -- .

# or

# Scaffold into a new named directory
pesde x nova/create -- <project-name>
```

### Examples

```bash
pesde x nova/create -- .

# or

pesde x nova/create -- my-nova-app
```

### Arguments

| Argument         | Description                                               |
|------------------|-----------------------------------------------------------|
| `.`              | Generate the project inside the current working directory |
| `<project-name>` | Generate the project inside a new directory with that name |

## Interactive Prompts

Once executed, the CLI will guide you through two prompts:

1. **Project name** — must follow pesde's package naming format: `scope/name` (e.g. `myorg/my_project`). Names are automatically normalized to lowercase with hyphens converted to underscores.
2. **Runtime** — choose between Zune, Lune, or Lute.

After scaffolding, run the following to get started:

```bash
# If you scaffolded into a new directory
cd <project-name>

pesde install

lune run start
# or
lute run start
# or
zune run start
```