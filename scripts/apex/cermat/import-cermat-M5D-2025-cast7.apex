String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PDD25C0T04';
Integer YEAR = 2025;

public class C {
  Map<String,Id> tx; Set<String> have; String src; String stype; String ccode; Integer yr; public Integer created=0;
  C(Map<String,Id> tx, Set<String> have, String src, String stype, String ccode, Integer yr){this.tx=tx;this.have=have;this.src=src;this.stype=stype;this.ccode=ccode;this.yr=yr;}
  Id sv(String t,String fn,String s){ContentVersion cv=new ContentVersion(Title=t,PathOnClient=fn,VersionData=Blob.valueOf(s),Origin='H');insert cv;return [SELECT ContentDocumentId FROM ContentVersion WHERE Id=:cv.Id].ContentDocumentId;}
  void lk(Id d,Id r){try{insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='AllUsers');}catch(Exception e){insert new ContentDocumentLink(ContentDocumentId=d,LinkedEntityId=r,ShareType='V',Visibility='InternalUsers');}}
  String para(String t){return '{"type":"paragraph","text":'+JSON.serialize(t)+'}';}
  String content(List<String> zad, Id d, String alt, String cap, List<String> opts, Integer ln){
    String s='{"schemaVersion":1,"blocks":[';
    for(Integer i=0;i<zad.size();i++){if(i>0)s+=',';s+=para(zad[i]);}
    if(d!=null){s+=',{"type":"image","contentDocumentId":"'+d+'","alt":'+JSON.serialize(alt)+',"caption":'+JSON.serialize(cap)+',"widthPercent":75,"align":"center"}';}
    if(opts!=null && !opts.isEmpty()){s+=',{"type":"list","items":[';for(Integer i=0;i<opts.size();i++){if(i>0)s+=',';s+=JSON.serialize(opts[i]);}s+=']}';}
    if(ln!=null && ln>0){s+=',{"type":"answerSpace","lines":'+ln+'}';}
    s+=']}';return s;
  }
  String solution(List<String> ps){String s='{"schemaVersion":1,"blocks":[';for(Integer i=0;i<ps.size();i++){if(i>0)s+=',';s+=para(ps[i]);}s+=']}';return s;}
  void add(String name,List<String> zad,List<String> opts,Integer ln,String svg,String fn,String alt,String cap,List<String> solp,String ans,Decimal pts,Decimal mins,String diff,List<String> codes){
    if(have.contains(name))return;
    Id d=(svg!=null)?sv(name,fn,svg):null;
    Math_Problem__c mp=new Math_Problem__c(Name=name,Status__c='Publikováno',Visibility__c='Organizace',Language__c='cs',Current_Version_Number__c=1);insert mp;
    String cj=content(zad,d,alt,cap,opts,ln); String sj=solution(solp);
    String aj=JSON.serialize(new Map<String,Object>{'type'=>'Text','value'=>ans});
    Problem_Version__c pub=new Problem_Version__c(Problem__c=mp.Id,Version_Number__c=1,Is_Published__c=true,Published_At__c=Datetime.now(),Title__c=name,Content_JSON__c=cj,Solution_JSON__c=sj,Answer_JSON__c=aj,Answer_Type__c='Text',Points__c=pts,Expected_Time_Min__c=mins,Difficulty__c=diff,Source__c=src,Source_Type__c=stype,CERMAT_Code__c=ccode,Source_Year__c=yr,License__c='Jiná',Search_Text__c=GoMathContent.buildSearchText(name,cj,sj,null));
    insert pub;
    List<Problem_Taxon__c> ls=new List<Problem_Taxon__c>();
    for(String code:codes){Id ti=tx.get(code);if(ti==null)continue;ls.add(new Problem_Taxon__c(Problem_Version__c=pub.Id,Taxon__c=ti,Unique_Key__c=pub.Id+'_'+ti));}
    if(!ls.isEmpty())insert ls;
    if(d!=null)lk(d,mp.Id);
    created++;
  }
}
Map<String,Id> tx=new Map<String,Id>();
for(Taxon__c t:[SELECT Id,Code__c FROM Taxon__c])tx.put(t.Code__c,t.Id);
Set<String> have=new Set<String>();
for(Math_Problem__c p:[SELECT Name FROM Math_Problem__c])have.add(p.Name);
C c=new C(tx,have,SRC,STYPE,CCODE,YEAR);

c.add(
  'CERMAT M5D 2025 - uloha 13',
  new List<String>{'Vsechny kostky ve stavebnici jsou stejne a maji tvar krychle. Ze vsech kostek stavebnice byla na podlozce postavena pyramida (obrazek vlevo). Jitka pyramidu zbourala a ze vsech kostek postavila stavbu naznacenou na obrazku uprostred. Nakonec Emil zboural i Jitcinu stavbu a ze vsech kostek postavil pravidelnou stavbu, jejiz ctyri horni patra jsou na obrazku vpravo. Zadna stavba nemela mezi kostkami mezery.','Priradte ke kazde uloze (13.1-13.3) odpovidajici vysledek (A-F).','13.1 Kolik kostek uvnitr pyramidy nebylo videt z zadne strany?','13.2 Kolik kostek v Jitcine stavbe se dotykalo podlozky?','13.3 Kolik kostek dohromady obsahuji spodni dve patra Emilovy stavby?'},
  new List<String>{'A) mene nez $15$ kostek','B) $15$ kostek','C) $18$ kostek','D) $21$ kostek','E) $26$ kostek','F) vice nez $26$ kostek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 520 120" font-family="sans-serif"> <text x="260" y="46" font-size="13" text-anchor="middle">Stavby z krychlovych kostek: pyramida, Jitcina a Emilova stavba (viz testovy sesit).</text> <text x="260" y="72" font-size="11" text-anchor="middle" fill="#666666">Prostorove stavby nelze verne prenest do SVG; posuzuje se podle originalu.</text> </svg>',
  'stavby-kostky.svg',
  'Pyramida a dalsi dve stavby z krychlovych kostek (schematicka poznamka).',
  'Prostorove stavby - viz testovy sesit',
  new List<String>{'Podle nacrtu v testovem sesitu: 13.1 uvnitr pyramidy nebylo videt mene nez $15$ kostek (A); 13.2 podlozky se v Jitcine stavbe dotykalo vice nez $26$ kostek (F); 13.3 spodni dve patra Emilovy pravidelne stavby obsahuji dohromady $26$ kostek (E).'},
  '13.1: A (mene nez $15$ kostek); 13.2: F (vice nez $26$ kostek); 13.3: E ($26$ kostek)',
  6, 8, '4',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5D 2025 - uloha 14',
  new List<String>{'Hriste ma tvar obdelniku $KLMN$. Po jeho obvodu vede soutezni trasa se stanovisti $A$, $B$, $C$, $D$ (viz obrazek). Usecky $AC$ a $BD$ jsou rovnobezne se stranami hriste a vyznaceny sedy obrazec je ctverec. Usek $AKB$ soutezni trasy (ze stanoviste $A$ pres vrchol $K$ na stanoviste $B$) meri $45$ m, usek $BLC$ meri $39$ m a posledni usek $CMD$ meri $30$ m.','Vypoctete v metrech:','14.1 rozdil mezi delkami usecek $BK$ a $BL$,','14.2 delku kratsi strany hriste,','14.3 obvod hriste,','14.4 vzdalenost stanoviste $D$ od vrcholu $N$.'},
  null,
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 440 300" font-family="sans-serif" font-size="13"> <rect x="256" y="30" width="144" height="144" fill="#cccccc" stroke="none"/> <rect x="40" y="30" width="360" height="240" fill="none" stroke="#000" stroke-width="2"/> <line x1="256" y1="30" x2="256" y2="270" stroke="#000" stroke-dasharray="4 4"/> <line x1="40" y1="174" x2="400" y2="174" stroke="#000" stroke-dasharray="4 4"/> <text x="30" y="28" font-style="italic">K</text> <text x="404" y="28" font-style="italic">N</text> <text x="30" y="284" font-style="italic">L</text> <text x="404" y="284" font-style="italic">M</text> <circle cx="256" cy="30" r="3" fill="#000"/><text x="248" y="24" font-style="italic">A</text> <circle cx="40" cy="174" r="3" fill="#000"/><text x="26" y="170" font-style="italic">B</text> <circle cx="256" cy="270" r="3" fill="#000"/><text x="250" y="288" font-style="italic">C</text> <circle cx="400" cy="174" r="3" fill="#000"/><text x="406" y="172" font-style="italic">D</text> </svg>',
  'hriste-KLMN.svg',
  'Obdelnikove hriste KLMN se stanovisti A, B, C, D na stranach; usecky AC a BD, vpravo nahore sedy ctverec.',
  'Hriste KLMN se soutezni trasou',
  new List<String>{'Ze zadani plati $AK+KB=45$, $BL+LC=39$ a $CM+MD=30$; sedy obrazec je ctverec, proto $NA=ND$ (strana ctverce $s$). Vyjadrenim vyjde $s=18$ m, dale $AK=27$ m, $KB=18$ m, $BL=12$ m, $LC=27$ m, $CM=18$ m, $MD=12$ m.','14.1 $BK-BL=18-12=6$ m.','14.2 Kratsi strana hriste $KL=KB+BL=18+12=30$ m.','14.3 Delsi strana $KN=AK+NA=27+18=45$ m; obvod $=2\\cdot(30+45)=150$ m.','14.4 Vzdalenost $D$ od vrcholu $N$ je rovna strane ctverce, tedy $18$ m.'},
  '14.1: $6$ m; 14.2: $30$ m; 14.3: $150$ m; 14.4: $18$ m',
  4, 7, '3',
  new List<String>{'zs1','planimetrie','modelovani','slovni','bez-kalkulacky','bezny-zivot'}
);

System.debug('Vytvořeno úloh: '+c.created);
