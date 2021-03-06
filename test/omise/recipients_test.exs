defmodule Omise.RecipientsTest do
  use ExUnit.Case, async: true

  setup do
    params = [
      name: "Edward Elric",
      email: "test_recp123@localhost",
      description: "Move on",
      type: "individual",
      bank_account: [
        brand: "bbl",
        number: "acc12345",
        name: "Edward Elric"
      ]
    ]

    {:ok, params: params}
  end

  test "list all recipients" do
    {:ok, recipients} = Omise.Recipients.list

    assert is_list(recipients.data)
  end

  test "create and retrieve a recipient", %{params: params} do
    {:ok, recipient} = Omise.Recipients.create(params)

    assert recipient.object == "recipient"
    assert recipient.bank_account != nil

    {:ok, retrieved_recipient} = recipient.id |> Omise.Recipients.retrieve

    assert recipient.id == retrieved_recipient.id
  end

  test "destroy a recipient", %{params: params} do
    {:ok, recipient} = Omise.Recipients.create(params)
    {:ok, data} = Omise.Recipients.destroy(recipient.id)

    assert data.deleted == true
  end
end
