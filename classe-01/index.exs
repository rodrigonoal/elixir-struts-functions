defmodule Test do
  defstruct [:student, :subject, :value, :questions]
end

defmodule Question do
    defstruct [:answer, :template]
  end

defmodule Main do
  def main do
    test = %Test{
      student: "Joãozinho",
      subject: "Portuguese",
      value: 10,
      questions: [
        %Question{answer: "a", template: "b"},
        %Question{answer: "c", template: "c"},
        %Question{answer: "e", template: "b"},
        %Question{answer: "b", template: "b"},
        %Question{answer: "c", template: "c"}
      ]
    }

    defmodule Evaluate do
      def calcGrade(test) do
        questionValue = div(test.value, length(test.questions))

        correct = fn question, acc ->
          if question.answer === question.template do
            questionValue + acc
          else
            0 + acc
          end
        end

        Enum.reduce(test.questions, 0, correct)
      end

      def printGrade(test) do
        grade = calcGrade(test)

        IO.puts "Student #{test.student} got #{grade}/#{test.value} in the #{test.subject} test"
      end
    end

    Evaluate.printGrade(test)
  end
end

Main.main()
