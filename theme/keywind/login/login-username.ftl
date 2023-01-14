<#import "template.ftl" as layout>
<#import "components/provider.ftl" as provider>
<#import "components/button/primary.ftl" as buttonPrimary>
<#import "components/checkbox/primary.ftl" as checkboxPrimary>
<#import "components/input/primary.ftl" as inputPrimary>
<#import "components/label/username.ftl" as labelUsername>
<#import "components/link/primary.ftl" as linkPrimary>

<@layout.registrationLayout 
  displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??
  displayMessage=!messagesPerField.existsError('username') 
  ; 
  section
>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
      <#if realm.password>
          <form 
            id="login-username" 
            action="${url.loginAction}"
            class="m-0 space-y-4"
            method="post"
            onsubmit="login.disabled = true; return true;" 
          >
              <#if !usernameHidden??>
                  <div>
                    <@inputPrimary.kw
                      autocomplete=realm.loginWithEmailAllowed?string("email", "username")
                      autofocus=true
                      disabled=usernameEditDisabled??
                      invalid=["username"]
                      name="username"
                      type="text"
                      value=(login.username)!''
                    >
                      <@labelUsername.kw />
                    </@inputPrimary.kw>
                  </div>
              </#if>
              
              <div class="flex items-center justify-between">
                <#if realm.rememberMe && !usernameEditDisabled??>
                  <@checkboxPrimary.kw checked=login.rememberMe?? name="rememberMe">
                    ${msg("rememberMe")}
                  </@checkboxPrimary.kw>
                </#if>
              </div>
              <div class="pt-4">
                <@buttonPrimary.kw name="login" type="submit">
                  ${msg("doLogIn")}
                </@buttonPrimary.kw>
              </div>
          </form>
      </#if>

    <#elseif section = "info" >
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <div id="kc-registration">
                <span>${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
            </div>
        </#if>
    <#elseif section = "socialProviders" >
        <#if realm.password && social.providers??>
            <div id="kc-social-providers" class="${properties.kcFormSocialAccountSectionClass!}">
                <hr/>
                <h4>${msg("identity-provider-login-label")}</h4>

                <ul class="${properties.kcFormSocialAccountListClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountListGridClass!}</#if>">
                    <#list social.providers as p>
                        <a id="social-${p.alias}" class="${properties.kcFormSocialAccountListButtonClass!} <#if social.providers?size gt 3>${properties.kcFormSocialAccountGridItem!}</#if>"
                                type="button" href="${p.loginUrl}">
                            <#if p.iconClasses?has_content>
                                <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                                <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                                <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                        </a>
                    </#list>
                </ul>
            </div>
        </#if>
    </#if>

</@layout.registrationLayout>
