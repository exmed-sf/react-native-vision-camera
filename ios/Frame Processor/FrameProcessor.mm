//
//  FrameProcessor.mm
//  VisionCamera
//
//  Created by Marc Rousavy on 13.07.23.
//  Copyright © 2023 mrousavy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FrameProcessor.h"

#import <memory>
#import <jsi/jsi.h>
#import "WKTJsiWorklet.h"
#import "FrameHostObject.h"

using namespace facebook;

@implementation FrameProcessor {
  std::shared_ptr<RNWorklet::JsiWorkletContext> _workletContext;
  std::shared_ptr<RNWorklet::WorkletInvoker> _workletInvoker;
}

- (instancetype)initWithWorklet:(std::shared_ptr<RNWorklet::JsiWorkletContext>)context worklet:(std::shared_ptr<RNWorklet::JsiWorklet>)worklet {
  if (self = [super init]) {
    _workletContext = context;
    _workletInvoker = std::make_shared<RNWorklet::WorkletInvoker>(worklet);
  }
  return self;
}

- (void)call:(Frame* _Nonnull)frame {
  // Call the Frame Processor on the Worklet Runtime
  jsi::Runtime& runtime = _workletContext->getWorkletRuntime();
  
  try {
    // Create the Frame Host Object wrapping the internal Frame
    auto frameHostObject = std::make_shared<FrameHostObject>(frame);
    auto argument = jsi::Object::createFromHostObject(runtime, frameHostObject);
    jsi::Value jsValue(std::move(argument));
    
    // Call the Worklet with the Frame JS Host Object as an argument
    _workletInvoker->call(runtime, jsi::Value::undefined(), &jsValue, 1);
  } catch (jsi::JSError& jsError) {
    // JS Error occured, print it to console.
    auto message = jsError.getMessage();
    
    _workletContext->invokeOnJsThread([message](jsi::Runtime& jsRuntime) {
      auto logFn = jsRuntime.global().getPropertyAsObject(jsRuntime, "console").getPropertyAsFunction(jsRuntime, "error");
      logFn.call(jsRuntime, jsi::String::createFromUtf8(jsRuntime, "Frame Processor threw an error: " + message));
    });
  }
}

@end
