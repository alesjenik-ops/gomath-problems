String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PCD23C0T03';
Integer YEAR = 2023;

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
  'CERMAT M5C 2023 – úloha 5',
  new List<String>{'Šestiúhelník na obrázku se skládá z rovnoramenného trojúhelníku, obdélníku a čtverce. Základna rovnoramenného trojúhelníku splývá s delší stranou obdélníku a rameno tohoto trojúhelníku je o 1 cm delší než strana čtverce. Obvod čtverce je stejný jako obvod trojúhelníku, ale o 8 cm menší než obvod obdélníku.','5.1 Vypočtěte, o kolik cm se liší délka a šířka obdélníku.','5.2 Vypočtěte, kolik cm měří rameno rovnoramenného trojúhelníku.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 300 170" font-family="sans-serif"> <rect x="40" y="90" width="60" height="60" fill="none" stroke="#000" stroke-width="2"/> <polygon points="40,90 100,90 70,45" fill="none" stroke="#000" stroke-width="2"/> <rect x="100" y="90" width="90" height="60" fill="none" stroke="#000" stroke-width="2"/> <text x="70" y="125" font-size="12" text-anchor="middle">čtverec</text> <text x="70" y="40" font-size="12" text-anchor="middle">trojúhelník</text> <text x="145" y="125" font-size="12" text-anchor="middle">obdélník</text> </svg>',
  'sestiuhelnik.svg',
  'Šestiúhelník složený ze čtverce, rovnoramenného trojúhelníku a obdélníku.',
  'Schematický nákres',
  new List<String>{'Označme stranu čtverce $a$; kratší strana obdélníku je také $a$ (viz obrázek), rameno trojúhelníku je $a+1$. Ze shodných obvodů čtverce a trojúhelníku: $4a=z+2(a+1)$, kde $z$ je základna trojúhelníku (a zároveň delší strana obdélníku), tedy $z=2a-2$.','Obvod obdélníku je o 8 cm větší než obvod čtverce: $2(a+z)=4a+8$, tj. $6a-4=4a+8$, odtud $a=6$ cm.','5.1 Obdélník má strany $z=2\\cdot 6-2=10$ cm a $6$ cm; liší se o $10-6=4$ cm.','5.2 Rameno trojúhelníku $=a+1=7$ cm.'},
  '5.1: o $4$ cm; 5.2: $7$ cm',
  3, 6, '3',
  new List<String>{'zs1','planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);
c.add(
  'CERMAT M5C 2023 – úloha 6',
  new List<String>{'Čtyřúhelník $ABCD$ na obrázku se skládá ze 7 šedých čtverců a 4 bílých čtverců. Obvod jednoho šedého čtverce je 48 cm.','6.1 Vypočtěte v cm obvod jednoho bílého čtverce.','6.2 Vypočtěte v cm obvod celého čtyřúhelníku $ABCD$.'},
  null,
  2,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 170 145" font-family="sans-serif"> <rect x="40" y="30" width="20" height="20" fill="#b9b9b9" stroke="#000"/> <rect x="60" y="30" width="20" height="20" fill="#b9b9b9" stroke="#000"/> <rect x="80" y="30" width="20" height="20" fill="#b9b9b9" stroke="#000"/> <rect x="100" y="30" width="20" height="20" fill="#b9b9b9" stroke="#000"/> <rect x="40" y="50" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="40" y="80" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="90" y="50" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="90" y="80" width="30" height="30" fill="#ffffff" stroke="#000"/> <rect x="70" y="50" width="20" height="20" fill="#b9b9b9" stroke="#000"/> <rect x="70" y="70" width="20" height="20" fill="#b9b9b9" stroke="#000"/> <rect x="70" y="90" width="20" height="20" fill="#b9b9b9" stroke="#000"/> <text x="30" y="28" font-size="13" font-weight="bold">D</text> <text x="122" y="28" font-size="13" font-weight="bold">C</text> <text x="30" y="124" font-size="13" font-weight="bold">A</text> <text x="122" y="124" font-size="13" font-weight="bold">B</text> </svg>',
  'ctyruhelnik-ABCD.svg',
  'Čtyřúhelník ABCD složený ze 7 šedých a 4 bílých čtverců.',
  'Schematický nákres',
  new List<String>{'6.1 Šedý čtverec má stranu $48:4=12$ cm. Horní řada obrazce je tvořena 4 šedými čtverci, šířka obrazce je $4\\cdot 12=48$ cm. V prostřední části tvoří šířku dva bílé čtverce a jeden šedý: $2b+12=48$, tedy strana bílého čtverce $b=18$ cm a jeho obvod $4\\cdot 18=72$ cm.','6.2 Čtyřúhelník $ABCD$ je čtverec o straně $48$ cm (výška $=12+2\\cdot 18=48$ cm), obvod $=4\\cdot 48=192$ cm.'},
  '6.1: $72$ cm; 6.2: $192$ cm',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','vypocet','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
