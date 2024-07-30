import 'package:flutter/material.dart';
import 'package:mobile_gmf/Theme.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          backgroundColor: whiteColor,
          title: Text('Pengaturan Lainnya',
              style: blackTextStyle.copyWith(
                  fontSize: 16, fontWeight: FontWeight.bold)),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: blackColor,
            ),
          ),
        ),
        body: Container(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 34,
                    width: 100,
                    // color: greenColor,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: greenColor,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: greenColor,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Akun', 
                          style: whitekTextStyle.copyWith(fontSize: 11),
                          textAlign: TextAlign.center,),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Container(
                    height: 34,
                    width: 100,
                    // color: greenColor,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: greyColor.withOpacity(0.25),
                      ),
                      borderRadius: BorderRadius.circular(10),
                      color: whiteColor,
                    ),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Tentang Aplikasi',
                          style: greyTextStyle.copyWith(fontSize: 11),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                    width: 340.0,
                    child: Container(
                        width: double.infinity,
                        margin: EdgeInsets.all(10),
                        height: 149,
                        decoration: BoxDecoration(
                          border: Border.all(
                            width: 1,
                            color: greyColor,
                          ),
                          borderRadius: BorderRadius.circular(10),
                          color: whiteColor.withOpacity(0.25),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 76,
                              width: 76,
                              decoration: const BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/profile_image2.png')),
                              ),
                            ),
                            Column(
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Edy Atthoillah',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 13, fontWeight: bold),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  'Karyawan',
                                  style: blackTextStyle.copyWith(
                                      fontSize: 12, fontWeight: light),
                                )
                              ],
                            ),
                          ],
                        )),
                        
                  ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      '+6285257315135', style: greyTextStyle.copyWith(fontSize: 11, fontWeight: light),
                    )
                  ],
                ),
                
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'edy@gmail.com', style: greyTextStyle.copyWith(fontSize: 11, fontWeight: light),
                    )
                  ],
                ),
                
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    
                    Container(
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Ganti Password', style: greyTextStyle.copyWith(fontSize: 11, fontWeight: light),
                    )
                  ],
                ),
          
              ),
              Container(
                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                height: 40,
                width: 340,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: greyColor.withOpacity(0.25),
                  ),
                  borderRadius: BorderRadius.circular(10),
                  color: whiteColor,
                ),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Logout', style: redTextStyle.copyWith(fontSize: 11, fontWeight: light),
                    )
                  ],
                ),
                
              ),
            ],
          ),
        )
        );
  }
}
