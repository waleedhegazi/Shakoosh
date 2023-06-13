import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:sms_otp_auto_verify/sms_otp_auto_verify.dart';
import 'dart:async';
import 'package:test_app/repository/Authentication_Repository.dart';

class OTPScreen extends StatefulWidget {
  final void Function(bool) isVerified;

  OTPScreen({required this.isVerified, super.key});
  @override
  State<OTPScreen> createState() {
    return _OTPScreenState();
  }
}

class _OTPScreenState extends State<OTPScreen> {
  int _otpCodeLength = 6;
  bool _isLoadingButton = false;
  bool _enableButton = false;
  String _otpCode = "";
  final intRegex = RegExp(r'\d+', multiLine: true);
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getSignatureCode();
    _startListeningSms();
  }

  @override
  void dispose() {
    super.dispose();
    SmsVerification.stopListening();
  }

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Colors.black87),
      borderRadius: BorderRadius.circular(5.0),
    );
  }

  /// get signature code
  _getSignatureCode() async {
    String? signature = await SmsVerification.getAppSignature();
    print("signature $signature");
  }

  /// listen sms
  _startListeningSms() {
    SmsVerification.startListeningSms().then((message) {
      setState(() {
        _otpCode = SmsVerification.getCode(message, intRegex);
        controller.text = _otpCode;
        _onOtpCallBack(_otpCode, true);
      });
    });
  }

  _onSubmitOtp() {
    setState(() {
      _isLoadingButton = !_isLoadingButton;
      _verifyOtpCode();
    });
  }

  _onClickRetry() {
    _startListeningSms();
  }

  _onOtpCallBack(String otpCode, bool isAutofill) {
    setState(() {
      this._otpCode = otpCode;
      if (otpCode.length == _otpCodeLength && isAutofill) {
        _enableButton = false;
        _isLoadingButton = true;
        _verifyOtpCode();
      } else if (otpCode.length == _otpCodeLength && !isAutofill) {
        _enableButton = true;
        _isLoadingButton = false;
      } else {
        _enableButton = false;
      }
    });
  }

  _verifyOtpCode() async {
    FocusScope.of(context).requestFocus(new FocusNode());
    bool check = await AuthenticationRepository.verifyOTP(_otpCode);
    widget.isVerified(check);
    Navigator.pop(context);
  }

  Widget _getSubmitWidget() {
    if (_isLoadingButton) {
      return Container(
        width: 19,
        height: 19,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    } else {
      return Text(
        "Submit",
        style: TextStyle(color: Colors.white),
      );
    }
  }

  @override
  Widget build(context) {
    double screenHeight = (MediaQuery.of(context).size.height) -
        (MediaQuery.of(context).padding.top) -
        (MediaQuery.of(context).padding.bottom);
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          width: screenWidth,
          height: screenHeight,
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                  height: 200,
                  width: 200,
                  child: Lottie.asset(
                      'assets/animations/logo_appears_from_down.json')),
              const Text(
                'Verification step!',
                style: TextStyle(fontSize: 25),
              ),
              const SizedBox(height: 10),
              const Text("Enter the verification code sent to you"),
              const SizedBox(height: 20),
              SizedBox(
                  //width: screenWidth * 0.7,
                  child: TextFieldPin(
                autoFocus: true,
                codeLength: _otpCodeLength,
                alignment: MainAxisAlignment.center,
                defaultBoxSize: 40.0,
                margin: 5,
                selectedBoxSize: 40.0,
                textStyle: TextStyle(fontSize: 15),
                defaultDecoration: _pinPutDecoration.copyWith(
                    border: Border.all(color: Colors.black45)),
                selectedDecoration: _pinPutDecoration,
                textController: controller,
                onChange: (code) {
                  _onOtpCallBack(code, false);
                },
              )),
              const SizedBox(height: 30),
              SizedBox(
                width: screenWidth * 0.7,
                child: MaterialButton(
                    child: _getSubmitWidget(),
                    onPressed: _enableButton ? _onSubmitOtp : null,
                    color: Colors.black87,
                    disabledColor: Colors.black26),
              ),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              TextButton(
                  onPressed: _onClickRetry,
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.transparent),
                  child: const Text(
                    "Retry",
                    style: TextStyle(color: Colors.black54),
                  )),
              SizedBox(
                height: screenHeight * 0.02,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style:
                      TextButton.styleFrom(backgroundColor: Colors.transparent),
                  child: const Text(
                    "Back",
                    style: TextStyle(color: Colors.black54),
                  ))
            ],
          )),
    ));
  }
}
