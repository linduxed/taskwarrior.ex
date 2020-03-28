defmodule TaskwarriorTest do
  use ExUnit.Case

  describe "from_json/2" do
    test "returns an empty list if JSON is empty list" do
      json_data = "[]\n"

      assert Taskwarrior.from_json(json_data) == []
    end

    test "returns a list of Task items for a valid Taskwarrior JSON" do
      json_data = """
      [
        {
          "id": 123,
          "description": "An uncompleted task",
          "due": "20200223T225214Z",
          "entry": "20191124T124932Z",
          "imask": 1,
          "modified": "20191210T193308Z",
          "parent": "00f371df-f5b5-44df-98e8-dcc0262d4f07",
          "project": "personal",
          "recur": "quarterly",
          "status": "pending",
          "tags": ["contact"],
          "uuid": "5c67dfa3-98de-4fc4-9cec-648175d3a87b",
          "urgency": 13.8052
        },
        {
          "id": 0,
          "description": "A completed task",
          "end": "20200229T193756Z",
          "entry": "20200228T173215Z",
          "modified": "20200229T193756Z",
          "project": "work",
          "status": "completed",
          "tags": [
            "programming",
            "foobar_client"
          ],
          "uuid": "9b3752e3-d34f-401f-bec3-47ba6549426a",
          "urgency": 1.9
        }
      ]
      """

      assert [task_a, task_b] = Taskwarrior.from_json(json_data)

      assert task_a == %Taskwarrior.Task{
               id: 123,
               uuid: "5c67dfa3-98de-4fc4-9cec-648175d3a87b",
               description: "An uncompleted task",
               due: ~U[2020-02-23 22:52:14Z],
               end: nil,
               entry: ~U[2019-11-24 12:49:32Z],
               modified: ~U[2019-12-10 19:33:08Z],
               project: "personal",
               status: "pending",
               tags: ["contact"],
               udas: %{},
               urgency: 13.8052
             }

      assert task_b == %Taskwarrior.Task{
               id: 0,
               uuid: "9b3752e3-d34f-401f-bec3-47ba6549426a",
               description: "A completed task",
               end: ~U[2020-02-29 19:37:56Z],
               entry: ~U[2020-02-28 17:32:15Z],
               modified: ~U[2020-02-29 19:37:56Z],
               project: "work",
               status: "completed",
               tags: ["programming", "foobar_client"],
               udas: %{},
               urgency: 1.9
             }
    end

    test "returns a list of Task items, even for Taskwarrior JSON with UDAs" do
      json_data = """
      [
        {
          "id": 0,
          "description": "A completed task",
          "end": "20200229T193756Z",
          "entry": "20200228T173215Z",
          "modified": "20200229T193756Z",
          "project": "work",
          "status": "completed",
          "tags": [
            "programming",
            "foobar_client"
          ],
          "uuid": "9b3752e3-d34f-401f-bec3-47ba6549426a",
          "urgency": 1.9,
          "uda_date": "20200320T193756Z",
          "uda_duration": "weekly",
          "uda_numeric": 123.4,
          "uda_string": "foobar"
        }
      ]
      """

      assert [task_with_udas] =
               Taskwarrior.from_json(
                 json_data,
                 udas: [
                   :uda_duration,
                   :uda_numeric,
                   :uda_string,
                   uda_date: :date
                 ]
               )

      assert task_with_udas == %Taskwarrior.Task{
               id: 0,
               uuid: "9b3752e3-d34f-401f-bec3-47ba6549426a",
               description: "A completed task",
               end: ~U[2020-02-29 19:37:56Z],
               entry: ~U[2020-02-28 17:32:15Z],
               modified: ~U[2020-02-29 19:37:56Z],
               project: "work",
               status: "completed",
               tags: ["programming", "foobar_client"],
               udas: %{
                 uda_date: ~U[2020-03-20 19:37:56Z],
                 uda_duration: "weekly",
                 uda_numeric: 123.4,
                 uda_string: "foobar"
               },
               urgency: 1.9
             }
    end
  end
end
