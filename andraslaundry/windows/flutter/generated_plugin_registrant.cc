//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <encrypt_decrypt_plus/encrypt_decrypt_plus_plugin_c_api.h>
#include <rive_common/rive_plugin.h>

void RegisterPlugins(flutter::PluginRegistry* registry) {
  EncryptDecryptPlusPluginCApiRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("EncryptDecryptPlusPluginCApi"));
  RivePluginRegisterWithRegistrar(
      registry->GetRegistrarForPlugin("RivePlugin"));
}
