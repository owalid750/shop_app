abstract class SearchStates{}
class SearchInitialState extends SearchStates{}
class SearchLoadingData extends SearchStates {}

class SearchDataSuccess extends SearchStates {}

class SearchDataError extends SearchStates {}