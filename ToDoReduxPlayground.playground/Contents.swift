//: Playground - noun: a place where people can play

import UIKit
import ReSwift

var str = "Hello, playground"

class TodoItem: CustomStringConvertible {
    var id: String
    var title: String
    var completed: Bool
    
    init(_ title: String, completed: Bool = false) {
        self.id = UUID().uuidString
        self.title = title
        self.completed = completed
    }
    
    var description: String {
        return completed ? "Done: " : "ToDo: " + title
    }
    
}

//var t = TodoItem("Testing the system")
//print(t)

struct AppState: StateType {
    var todoList = [TodoItem]()
}

struct TodoItemAddAction: Action {
    let todoItem: TodoItem
}

func todoItemReducer(action: Action, state: AppState?) -> AppState {
    var state = state ?? AppState()
    
    switch action {
    case let action as TodoItemAddAction:
            state.todoList.append(action.todoItem)

        default:
            break
    }
    
    return state
}

let mainStore = Store<AppState>(
    reducer: todoItemReducer,
    state: nil
)
mainStore.dispatch(TodoItemAddAction(todoItem: TodoItem("New Todo Item")))

@objc class ViewModel: NSObject, StoreSubscriber {
    typealias StoreSubscriberStateType = AppState
    
    override init() {
        super.init()
        mainStore.subscribe(self)
    }
    func newState(state: AppState) {
            for item in state.todoList {
                print(item)
            }
            print("----"
    }
}
var viewModel = ViewModel()

mainStore.dispatch(TodoItemAddAction(todoItem: TodoItem("Next Todo Item")))


