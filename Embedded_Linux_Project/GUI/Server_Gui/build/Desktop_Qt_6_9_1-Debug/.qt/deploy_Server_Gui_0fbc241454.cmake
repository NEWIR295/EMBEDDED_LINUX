include("/home/newir529/Server_Gui/build/Desktop_Qt_6_9_1-Debug/.qt/QtDeploySupport.cmake")
include("${CMAKE_CURRENT_LIST_DIR}/Server_Gui-plugins.cmake" OPTIONAL)
set(__QT_DEPLOY_I18N_CATALOGS "qtbase;qtdeclarative;qtdeclarative;qtdeclarative;qtdeclarative;qtdeclarative;qtdeclarative;qtdeclarative;qtdeclarative")

qt6_deploy_runtime_dependencies(
    EXECUTABLE /home/newir529/Server_Gui/build/Desktop_Qt_6_9_1-Debug/Server_Gui
    GENERATE_QT_CONF
)
