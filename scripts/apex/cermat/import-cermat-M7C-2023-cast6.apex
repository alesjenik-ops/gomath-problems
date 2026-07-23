String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M7PCD23C0T03';
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
  'CERMAT M7C 2023 - uloha 13',
  new List<String>{'Stavebnice obsahuje stejne dlouhe drevene tycky a plastove kulicky se sesti dirami, do nichz lze tycky pripevnovat. Denisa vytvorila z $8$ kulicek a $12$ tycek model nejmensi mozne krychle. Emil vytvoril model druhe nejmensi krychle; jeho model obsahuje celkem $27$ kulicek a $54$ tycek. Filip vytvoril stejnym zpusobem model treti nejmensi krychle, ktery obsahuje celkem $144$ tycek.','Kolik kulicek celkem obsahuje Filipuv model krychle?'},
  new List<String>{'A) $36$ kulicek','B) $48$ kulicek','C) $56$ kulicek','D) $64$ kulicek','E) jiny pocet kulicek'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 540 210" font-family="sans-serif"><rect x="30" y="110" width="44" height="44" fill="none" stroke="#000" stroke-width="1.6"/><rect x="48" y="92" width="44" height="44" fill="none" stroke="#000" stroke-width="1.2"/><line x1="30" y1="110" x2="48" y2="92" stroke="#000" stroke-width="1.2"/><line x1="74" y1="110" x2="92" y2="92" stroke="#000" stroke-width="1.2"/><line x1="74" y1="154" x2="92" y2="136" stroke="#000" stroke-width="1.2"/><line x1="30" y1="154" x2="48" y2="136" stroke="#000" stroke-width="1.2"/><text x="60" y="185" font-size="12" text-anchor="middle">Denisin model</text><rect x="170" y="100" width="64" height="64" fill="none" stroke="#000" stroke-width="1.6"/><rect x="197" y="73" width="64" height="64" fill="none" stroke="#000" stroke-width="1.2"/><line x1="170" y1="100" x2="197" y2="73" stroke="#000" stroke-width="1.2"/><line x1="234" y1="100" x2="261" y2="73" stroke="#000" stroke-width="1.2"/><line x1="234" y1="164" x2="261" y2="137" stroke="#000" stroke-width="1.2"/><line x1="170" y1="164" x2="197" y2="137" stroke="#000" stroke-width="1.2"/><text x="212" y="185" font-size="12" text-anchor="middle">Emiluv model</text><rect x="330" y="95" width="84" height="84" fill="none" stroke="#000" stroke-width="1.6"/><rect x="365" y="60" width="84" height="84" fill="none" stroke="#000" stroke-width="1.2"/><line x1="330" y1="95" x2="365" y2="60" stroke="#000" stroke-width="1.2"/><line x1="414" y1="95" x2="449" y2="60" stroke="#000" stroke-width="1.2"/><line x1="414" y1="179" x2="449" y2="144" stroke="#000" stroke-width="1.2"/><line x1="330" y1="179" x2="365" y2="144" stroke="#000" stroke-width="1.2"/><text x="382" y="185" font-size="12" text-anchor="middle">Filipuv model</text><text x="500" y="130" font-size="30" text-anchor="middle">?</text><text x="270" y="30" font-size="11" text-anchor="middle" fill="#666">Schematicky nakres modelu krychli (viz testovy sesit).</text></svg>',
  'krychle-modely-13.svg',
  'Tri modely krychli ze zvetsujicim se poctem kulicek (Denisin, Emiluv, Filipuv).',
  'Schematicky nakres (prostorova telesa nelze verne prenest)',
  new List<String>{'Modely tvori mrizku kulicek. Denisin model ma $2\\times 2\\times 2=8$ kulicek, Emiluv $3\\times 3\\times 3=27$ kulicek. Filipuv (treti nejmensi) ma $4\\times 4\\times 4=64$ kulicek.'},
  'D) $64$ kulicek',
  2, 3, '2',
  new List<String>{'zs2','r7','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
