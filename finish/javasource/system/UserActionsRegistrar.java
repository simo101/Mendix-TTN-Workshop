package system;

import aQute.bnd.annotation.component.Component;
import aQute.bnd.annotation.component.Reference;

import com.mendix.core.actionmanagement.IActionRegistrator;

@Component(immediate = true)
public class UserActionsRegistrar
{
  @Reference
  public void registerActions(IActionRegistrator registrator)
  {
    registrator.bundleComponentLoaded();
    registrator.registerUserAction(mqttclient.actions.MqttInitialize.class);
    registrator.registerUserAction(mqttclient.actions.MqttPublish.class);
    registrator.registerUserAction(mqttclient.actions.MqttSubscribe.class);
    registrator.registerUserAction(mqttclient.actions.MqttUnsubscribe.class);
    registrator.registerUserAction(system.actions.VerifyPassword.class);
  }
}
