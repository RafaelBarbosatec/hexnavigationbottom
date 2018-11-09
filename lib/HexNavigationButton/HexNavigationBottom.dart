
import 'package:flutter/material.dart';
import 'package:hexnavigationbottom/HexNavigationButton/HexagonoButton.dart';

class HexNavigationBottomController{
  Function(int) changeItemSelected = (p){};
}

class HexNavigationBottom extends StatefulWidget{

  final List<Icon> itens;
  final Function(int) itemSelectedListern;
  final Color colorAsset;
  final Color colorAssetSecond;
  final Color colorBar;
  final Color colorUnselected;
  final GestureTapCallback onTapMain;
  final Icon iconMain;
  final HexNavigationBottomController controller;

  HexNavigationBottom({
    Key key,
    this.itens,
    this.itemSelectedListern,
    this.colorAsset = Colors.blue,
    this.colorAssetSecond = Colors.purple,
    this.onTapMain,
    this.colorBar = Colors.white,
    this.iconMain,
    this.colorUnselected = Colors.grey,
    this.controller})
      : assert(itens.length > 0  && itens.length < 5),
        super(key: key);

  @override
  HexNavigationBottomState createState() => new HexNavigationBottomState();
}

class HexNavigationBottomState extends State<HexNavigationBottom> {

  var selected = 0;

  @override
  void initState() {
    confController();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return _buildNavigationBar();
  }

  _buildNavigationBar() {
    return new Container(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 25.0),
            child: Material(
              elevation: 6.0,
              color: widget.colorBar,
              child: SafeArea(
                top: false,
                child: new Container(
                    height: 70.0,
                    margin: EdgeInsets.only(left: 10.0,right: 10.0),
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: _buildItens(),
                    )
                ),
              ),
            ),
          ),
          Container(
            child: Center(
              child: HexagonoButton(
                  icon:widget.iconMain == null? Icon(Icons.add,color: Colors.white,) : widget.iconMain,
                  size: 70.0,
                  color: widget.colorAsset,
                  endColor: widget.colorAssetSecond,
                  onTap: widget.onTapMain
              ),
            ),
          )
        ],
      ),
    );
  }

  _buildItens() {
    if(widget.itens == null || widget.itens.length < 4){
      return [Text("Nessesarios assar 4 itens")];
    }else
    return <Widget>[
      new IconButton(onPressed: (){selectedPosition(0);},icon: Icon(widget.itens[0].icon,color: selected == 0 ? widget.colorAsset : Colors.grey, size: widget.itens[0].size,),),
      new IconButton(onPressed: (){selectedPosition(1);},icon: Icon(widget.itens[1].icon,color: selected == 1 ? widget.colorAsset : Colors.grey, size: widget.itens[1].size),),
      new Container(width: 50.0,),
      new IconButton(onPressed: (){selectedPosition(2);},icon: Icon(widget.itens[2].icon,color: selected == 2 ? widget.colorAsset : Colors.grey, size: widget.itens[2].size),),
      new IconButton(onPressed: (){selectedPosition(3);},icon: Icon(widget.itens[3].icon,color: selected == 3 ? widget.colorAsset : Colors.grey, size: widget.itens[3].size),),
    ];
  }

  void selectedPosition(int i) {
    widget.itemSelectedListern(i);
    setState(() {
      selected = i;
    });
  }

  void confController() {
    if(widget.controller != null){
      widget.controller.changeItemSelected = (p){
        if(p >= 0 && p < 4 && p != selected){
          selectedPosition(p);
        }
      };
    }
  }

}