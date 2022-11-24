#  DI & VIP 추상화

# DependencyContainer
 종속성 주입을 위한 클래스 
 
# UIViewController+
  1) protocol CommonVC 
    공통적으로 VIP 패턴을 적용할 ViewController 용 procotol
  2) Method Swizzling
  UIViewController life Cycle을 트래킹 하기위함. 앱 최초시작시 실행해야됨.
  보통 didFinishLaunchingWithOptions()에서 호출한다.
  https://babbab2.tistory.com/76
  고급 라이브러리들은 이 기술을 사용함으로 개념적으로 알고 넘어가야함!
   
# SimpleRouter
  RoutingEvent 내에 타입정의가 필요
  Navigationtype -> ViewController 별로 Case 처리 필요
  Segmenttype -> Segment 별로 Case 처리 필요
  DataPassingType -> Next UIViewController 에 상속 bind() 함수를 통해 받은 데이터를 캐스트 해서 사용 (무조건 구조체로 던져야함)
  
  RoutingLogicType -> Enum 상속 구현필수
  NavigationType -> RoutingLogicType 하위 Enum 상속 구현필수 
  SegmentType -> RoutingLogicType 하위 Enum 상속 구현필수

# WorkerType
   1) WorkerDelegate.completeWork()
   서버통신 및 단순 작업을 완료함
   
   2) WorkerType.recept(Int)
   개별 작업코드를 Int로 저장 
   설명 : 이 Int 값은 1)에서 해당 작업을 케이스 처리하기위해 필요
   
   3) WorkerType.api(_) 
   Api 서비스 호출 사용이 아주 간편하게 개편되었습니다. 
   
   4)SimpleWoker
   WorkerType의 샘플입니다. 아직 사용하지마세요!
   
   5)WorkResult
   result : 작업의 결과 혹은 통신의 성공 실패 여부 Bool값
   obj : api 통신후 리스폰 받는 JSON으로 Dictionary<String,Any>? 원시형태로 1차저장
   
   5-1)WorkResult.fetch(DefaultDataModelType.Type) 
   DefaultDataModelType을 다운 캐스팅 하기위한 제네릭함수
   func completeWork(orderNumber: Int, reulst: WorkResult) {
        let d = reulst.fetch(ChildDataModel.self)
   }
   
   추가 - 아직 Api 통신 외의 케이스 외 작업케이스가 있는경우는 알려주세요!
# DefaultDataModel
  데이터 모델의 최상위 객체로 class타입
  init 함수시 Dictionary<String,Any> 형태로 변환된 JSON데이터를 dic 변수에 저장 후 
  build() 함수를 호출함.
  따라서 DefaultDataModel 상속받은 모델클래스 내에 Build() 함수내에서 개별적인 
  변수할당을 하면됨. DefaultDataModel.swift를 직접 보고 판단해주세요~  
   
# InteractorType
 작업중
 1) View에서 모든 Action 이벤트는 InteractorType의 Just() 함수를 호출하도록 할예정입니다.
 2) just 함수를 호출하면 worker를 반환하여 api(_)를 호출하거나 drop()을 호출 하세요 drop은 따로 작업없이 바로 presneter로 이벤트를 통과시킵니다. 
 3) Just 로 전달된 orderNumber 는 presneter 의 delegate를 통해 display-로시작하는 함수들로 반환됩니다.
  
# BusinessLogicType
 이 프로토콜은 구현이 필요없습니다. (UseCase와 통합개념) 
# BasePresenter
    Delegate 형태로 개발되었습니다. 
# UseCaseType
  1) VC 별로 하위 Enum 클래스 (Int,OrderType 상속필수) 를 만들어 관리할 작업 단위를 작성하세요.
  2) 탭을 포함한 인터렉션 이벤트를 갖는 View에 tag로 UseCase의 RawValue를 넣어주세요.
  3) 클릭이벤트를 연결합니다. 
  4) 클릭이벤트를 처리하는 곳에서 전달된 Tag 값을 UseCase로 변환하고 interactor.just 로 해당 값을 전달합니다.
  
#TableCellViewModel + 
기본적으로 한 TableView의 다수의 UITableViewCell을 사용하기위해 공통 인수를 제공하도록 확장된 코드들로 구성되어있습니다.

1) ObservingTableCell <--상속--> UITableViewCell
기능 1) TableCellViewModel이 업데이트 될떄마다 UI를 업데이트 합니다.
기능 2) ObservingTableCellEvent 에게 인터랙션 이벤트를 전달 합니다. ( 이 delegate는 VC로 전달 됩니다. )
기능 3) binding 함수로 데이터를 전달하고 ChangeData 에서 UI를 갱신합니다.
기능 4) sendEventToController(sender : UITapGestureRecognizer) 클릭이벤트를 VC로 전달하기위한 공통함수 입니다. 

2) IdentifiableTableCell 
기능 ) UITableViewCell을 확장하여 nib (UINib) 과 Name(class 명)을 제공 합니다 

3) UITableView.register(cells : [ (UINib,String) ]) 
기능 2)로 확장된 UITableViewCell을 Array로 다량 등록하기위해 확장한 기능함수 입니다.
