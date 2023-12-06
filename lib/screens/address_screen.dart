import 'package:e_commerce/model/address_model.dart';
import 'package:flutter/material.dart';
import 'package:e_commerce/database/database_helper.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  var fullName = TextEditingController();
  var mobileNumber = TextEditingController();
  var buildingName = TextEditingController();
  var street = TextEditingController();
  var city = TextEditingController();
  var state = TextEditingController();
  var pinCode = TextEditingController();
  String radioValue = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address",style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontFamily: "sans-serif-condensed-light"),),
        centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Color(0xffF67952)),),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(alignment: Alignment.topLeft,
                padding: EdgeInsets.only(left: 6),
                child: Text("Add Address",style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey.shade700,
                    fontFamily: "sans-serif-condensed-light"),),
              ),
              SizedBox(height: 10,),
              Card(
                shape:OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.white)),
                elevation: 10,
                child: Container(
                  padding: EdgeInsets.all(10),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(alignment: Alignment.topLeft,
                        child: Text("User Info :",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                            fontFamily: "sans-serif-condensed-light"),),
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        controller: fullName,
                        cursorColor: Color(0xffF67952),
                        decoration: InputDecoration(
                          labelText: "Full Name",
                          labelStyle: TextStyle(color: Color(0xffF67952)),
                          focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                        )
                      ),
                      SizedBox(height: 10,),
                      TextField(
                        controller: mobileNumber,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelStyle: TextStyle(color: Color(0xffF67952)),
                          labelText: "Mobile Number",
                            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                        ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  )
                ) ,
              ),
              SizedBox(height: 30,),
              Card(
                shape:OutlineInputBorder(borderRadius: BorderRadius.circular(10),borderSide: BorderSide(color: Colors.white)),
                elevation: 10,
                child: Container(
                    padding: EdgeInsets.all(10),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(alignment: Alignment.topLeft,
                          child: Text("Address Info :",style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                              fontFamily: "sans-serif-condensed-light"),),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                            controller: buildingName,
                            cursorColor: Color(0xffF67952),
                            decoration: InputDecoration(
                                labelText: "Building Name/Flat no/Door no ",
                                labelStyle: TextStyle(color: Color(0xffF67952)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                            )
                        ),
                        SizedBox(height: 10,),
                        TextField(
                          controller: street,
                          decoration: InputDecoration(
                              labelStyle: TextStyle(color: Color(0xffF67952)),
                              labelText: "Street / Area / Locality",
                              focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextField(
                            controller: city,
                            cursorColor: Color(0xffF67952),
                            decoration: InputDecoration(
                                labelText: "City / Village ",
                                labelStyle: TextStyle(color: Color(0xffF67952)),
                                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                            )
                        ),
                        SizedBox(height: 10,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              width: 160,
                              child: TextField(
                                  controller: pinCode,
                                  keyboardType: TextInputType.number,
                                  cursorColor: Color(0xffF67952),
                                  decoration: InputDecoration(
                                      labelText: "Pin Code",
                                      labelStyle: TextStyle(color: Color(0xffF67952)),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                  )
                              ),
                            ),
                            SizedBox(
                              width: 160,
                              child: TextField(
                                  controller: state,
                                  cursorColor: Color(0xffF67952),
                                  decoration: InputDecoration(
                                      labelText: "State",
                                      labelStyle: TextStyle(color: Color(0xffF67952)),
                                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Color(0xffF67952)))
                                  )
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                      ],
                      
                    )
                ) ,
              ),
              SizedBox(height: 30,),
              Card(
                elevation: 10,
                shape: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white),borderRadius: BorderRadius.circular(10)),
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(alignment: Alignment.topLeft,
                        child: Text("Type of Address :",style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade700,
                            fontFamily: "sans-serif-condensed-light"),),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        height: 180,
                        child: ListView(
                          children: [
                            RadioListTile(activeColor: Color(0xffF67952),title:Text("Home",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                                fontFamily: "sans-serif-condensed-light"),) ,value: "Home", groupValue: radioValue, onChanged: (value){
                              setState(() {
                                radioValue = value!;
                                print(radioValue);
                              });

                            }),
                            RadioListTile(activeColor: Color(0xffF67952),title:Text("Work",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                                fontFamily: "sans-serif-condensed-light"),),value: "Work", groupValue: radioValue, onChanged: (value){
                              setState(() {
                                radioValue = value!;
                                print(radioValue);
                              });
                            }),
                            RadioListTile(activeColor: Color(0xffF67952),title:Text("Others",style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade700,
                                fontFamily: "sans-serif-condensed-light"),),value: "Others", groupValue: radioValue, onChanged: (value){
                              setState(() {
                                radioValue = value!;
                                print(radioValue);
                              });
                            })
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: 150,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffF67952),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40))),
                          onPressed: () async{
                            if(fullName.text.isNotEmpty && mobileNumber.text.isNotEmpty && buildingName.text.isNotEmpty && street.text.isNotEmpty && state.text.isNotEmpty && pinCode.text.isNotEmpty && city.text.isNotEmpty && radioValue.isNotEmpty){
                              await DatabaseHelper.instance.addAddress(Address(fullName: fullName.text.toString(), mobileNumber: mobileNumber.text.toString(), buildingName: buildingName.text.toString(), street: street.text.toString(), state: state.text.toString(), pinCode: int.parse(pinCode.text.toString()), city: city.text.toString(), addressType: radioValue));
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Address Added Successfully")));
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  title: Text(
                                    "Address",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "sans-serif-condensed-light"),
                                  ),
                                  content: Text(
                                    "Address Added Successfully",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "sans-serif-condensed-light"),
                                  ),
                                  actions: [
                                    TextButton(onPressed: (){
                                      setState(() {
                                        Navigator.pop(context);
                                      });
                                    }, child: Text("Done"))
                                  ],
                                );
                              });
                              fullName.clear();
                              mobileNumber.clear();
                              buildingName.clear();
                              street.clear();
                              city.clear();
                              pinCode.clear();
                              state.clear();
                              setState(() {
                                initState();
                              });
                            }
                            else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Enter All the Details")));
                            }

                          },
                          child: Text(
                            "Add Address",
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: "sans-serif-condensed-light"),
                          ),
                        ),
                      ),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                padding: EdgeInsets.all(10),
                height: 600,
                width: double.infinity,
                child:
                FutureBuilder<List<Address>>(
                  future: DatabaseHelper.instance.getAddress(),
                  builder: (BuildContext context,AsyncSnapshot<List<Address>> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(
                          child: Text("Loading...",
                              style:
                              TextStyle(color: Color(0xffF67952), fontSize: 30)));
                    }
                    return snapshot.data!.isEmpty
                        ? Center(
                        child: Text("No Addresses to Display",
                            style:
                            TextStyle(color: Color(0xffF67952), fontSize: 30)))
                        : ListView(
                      children: snapshot.data!.map((e) {
                        return Card(
                          elevation: 10,
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white)),
                          child: Container(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(e.fullName,style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),),
                                SizedBox(height: 10,),
                                Text(e.buildingName,style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),),
                                Text(e.street,style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),),
                                Text(e.city,style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),),
                                Text(e.state,style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),),
                                Text(e.pinCode.toString(),style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),),
                                SizedBox(height: 10,),
                                Text("Phone : ${e.mobileNumber}",style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade700,
                                    fontFamily: "sans-serif-condensed-light"),),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  },
                ),
              )
              
            ],
          ),
        ),
      ),
    );
  }
}
