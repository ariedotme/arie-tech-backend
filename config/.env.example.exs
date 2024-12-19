# A file .env.exs needs to be created in the config directory with the following content:

System.put_env("DB_USERNAME", "myusername")
System.put_env("DB_PASSWORD", "mypassword")
System.put_env("DB_DATABASE", "mydatabase")
System.put_env("DB_HOSTNAME", "localhost")
System.put_env("DB_PORT", "5432")

