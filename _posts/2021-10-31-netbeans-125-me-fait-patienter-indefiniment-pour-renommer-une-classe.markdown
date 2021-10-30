---
layout: post
title: "Netbeans 12.5 me fait patienter indéfiniment pour renommer une classe"
categories: informatique
# featured-image: 
# featured-source: 
summary: "En voulant renommer une classe dans un projet Maven tout neuf de NB 12.5, je me heurte à une attente sans fin, qui se résout finalement aisément."
---

Le message vu dans `~/.netbeans/12.5/var/log/messages.log` est :

    SEVERE [org.openide.util.RequestProcessor]: Error in RequestProcessor org.netbeans.modules.refactoring.spi.impl.ParametersPanel$12
    java.lang.IllegalArgumentException: file:/home/youngfrog/NetBeansProjects/mavenproject1/src/test/java is not a valid classpath entry; it must end with a slash.
        at org.netbeans.modules.java.classpath.SimplePathResourceImplementation.verify(SimplePathResourceImplementation.java:90)
        at org.netbeans.modules.java.classpath.SimplePathResourceImplementation.verify(SimplePathResourceImplementation.java:43)
        at org.netbeans.modules.java.classpath.SimplePathResourceImplementation.<init>(SimplePathResourceImplementation.java:108)
        at org.netbeans.spi.java.classpath.support.ClassPathSupport.createResource(ClassPathSupport.java:54)
        at org.netbeans.spi.java.classpath.support.ClassPathSupport.createClassPath(ClassPathSupport.java:124)
        at org.netbeans.modules.testng.DefaultPlugin.getOppositeLocation(DefaultPlugin.java:242)
        at org.netbeans.modules.testng.DefaultPlugin.getTestLocation(DefaultPlugin.java:183)
        at org.netbeans.modules.testng.GoToOppositeAction.appliesTo(GoToOppositeAction.java:335)
        at org.netbeans.modules.refactoring.java.ui.RenamePanel$2.run(RenamePanel.java:158)
        at org.netbeans.modules.refactoring.java.ui.RenamePanel$2.run(RenamePanel.java:113)
        at org.netbeans.api.java.source.JavaSource$MultiTask.run(JavaSource.java:502)
        at org.netbeans.modules.parsing.impl.TaskProcessor.callUserTask(TaskProcessor.java:586)
        at org.netbeans.modules.parsing.api.ParserManager$UserTaskAction.run(ParserManager.java:130)
        at org.netbeans.modules.parsing.api.ParserManager$UserTaskAction.run(ParserManager.java:114)
        at org.netbeans.modules.parsing.impl.TaskProcessor$2.call(TaskProcessor.java:181)
        at org.netbeans.modules.parsing.impl.TaskProcessor$2.call(TaskProcessor.java:178)
        at org.netbeans.modules.masterfs.filebasedfs.utils.FileChangedManager.priorityIO(FileChangedManager.java:153)
        at org.netbeans.modules.masterfs.providers.ProvidedExtensions.priorityIO(ProvidedExtensions.java:335)
        at org.netbeans.modules.parsing.nb.DataObjectEnvFactory.runPriorityIO(DataObjectEnvFactory.java:118)
        at org.netbeans.modules.parsing.impl.Utilities.runPriorityIO(Utilities.java:67)
        at org.netbeans.modules.parsing.impl.TaskProcessor.runUserTask(TaskProcessor.java:178)
        at org.netbeans.modules.parsing.api.ParserManager.parse(ParserManager.java:81)
        at org.netbeans.api.java.source.JavaSource.runUserActionTaskImpl(JavaSource.java:452)
        at org.netbeans.api.java.source.JavaSource.runUserActionTask(JavaSource.java:423)
        at org.netbeans.modules.refactoring.java.ui.RenamePanel.initialize(RenamePanel.java:184)
        at org.netbeans.modules.refactoring.spi.impl.ParametersPanel$12.run(ParametersPanel.java:641)
        at org.openide.util.RequestProcessor$Task.run(RequestProcessor.java:1418)
        at org.netbeans.modules.openide.util.GlobalLookup.execute(GlobalLookup.java:45)
        at org.openide.util.lookup.Lookups.executeWith(Lookups.java:278)
    [catch] at org.openide.util.RequestProcessor$Processor.run(RequestProcessor.java:2033)

Au vu du message, j'ai tenté et réussi à contourner le problème en... créant des tests unitaires.

Drôle de façon d'imposer des tests unitaires, mon cher Netbeans ;-)

Je n'ose pas faire un bug report.

En cherchant à résoudre le souci ci-dessus, je suis tombé sur `Window -> IDE Tools -> Exception Reporter`, qui me dit ceci:

    No data found at http://statistics.netbeans.org/analytics/nbfeedback_69.do?userId=...
    The problem can be caused by broken internet connection or on server side. Try to report problem later again. If you would face this problem repeatedly, submit a bug at https://netbeans.org/bugzilla/enter_bug.cgi against Exception reporter, please.

où `...` ressemble fort à un UUID que je n'ai pas envie de reproduire ici.
Je suspecte que ceci est lié à la reprise de NB par la fondation Apache, mais c'est de la simple hypothèse.
