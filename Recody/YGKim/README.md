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
  Navigation type -> ViewController 별로 Case 처리 필요
  Segment type -> Segment 별로 Case 처리 필요

# BaseInteractor
  미구현
# BasePresenter
  미구현
# UseCaseType
  미구현
