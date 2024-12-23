defmodule Discuss.Repo.Migrations.AddTopics do
  use Ecto.Migration

  def change do
    # create a new table called topics.There is a column called title with a type od string.
    create table(:topics) do
      add :title, :string
    end
  end
end 
