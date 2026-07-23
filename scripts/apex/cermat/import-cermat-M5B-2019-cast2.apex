String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PBD19C0T02';
Integer YEAR = 2019;

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
  'CERMAT M5B 2019 – úloha 6',
  new List<String>{'Na papírové pásce jsou vyznačeny shodné čtverečky. Adéla z pásky odstřihla $3$ proužky tvaru obdélníku, první proužek je nejkratší a třetí je nejdelší. Třetí proužek je šestkrát delší než první a skládá se jen z celých čtverečků. Druhý proužek je čtyřikrát delší než první a skládá se přesně z $10$ čtverečků. První proužek obsahuje kromě $2$ celých čtverečků ještě $2$ cm pásky.','6.1 Určete počet čtverečků na třetím proužku.','6.2 Určete v cm šířku papírové pásky.','6.3 Určete v cm délku prvního proužku.'},
  null,
  3,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 590 118" font-family="sans-serif"><g stroke="#000" stroke-width="1" stroke-dasharray="3 3"><line x1="74" y1="36" x2="74" y2="74"/><line x1="96" y1="36" x2="96" y2="74"/><line x1="171" y1="36" x2="171" y2="74"/><line x1="202" y1="36" x2="202" y2="74"/><line x1="233" y1="36" x2="233" y2="74"/><line x1="264" y1="36" x2="264" y2="74"/><line x1="295" y1="36" x2="295" y2="74"/><line x1="326" y1="36" x2="326" y2="74"/><line x1="357" y1="36" x2="357" y2="74"/><line x1="388" y1="36" x2="388" y2="74"/><line x1="419" y1="36" x2="419" y2="74"/><line x1="511" y1="36" x2="511" y2="74"/><line x1="529" y1="36" x2="529" y2="74"/><line x1="547" y1="36" x2="547" y2="74"/></g><text x="6" y="60" font-size="11">šířka</text><line x1="46" y1="36" x2="46" y2="74" stroke="#000"/><polygon points="46,36 43,43 49,43" fill="#000"/><polygon points="46,74 43,67 49,67" fill="#000"/><rect x="52" y="36" width="66" height="38" fill="none" stroke="#000" stroke-width="1.4"/><rect x="140" y="36" width="310" height="38" fill="none" stroke="#000" stroke-width="1.4"/><rect x="493" y="36" width="72" height="38" fill="none" stroke="#000" stroke-width="1.4"/><line x1="52" y1="86" x2="74" y2="86" stroke="#000"/><polygon points="52,86 57,83 57,89" fill="#000"/><polygon points="74,86 69,83 69,89" fill="#000"/><line x1="140" y1="86" x2="450" y2="86" stroke="#000"/><polygon points="140,86 145,83 145,89" fill="#000"/><polygon points="450,86 445,83 445,89" fill="#000"/><circle cx="480" cy="55" r="13" fill="#eee" stroke="#000"/><circle cx="480" cy="55" r="4" fill="#fff" stroke="#000"/><g font-size="11" text-anchor="middle"><text x="63" y="100">2 cm</text><text x="295" y="100">délka proužku</text></g><g font-size="12" text-anchor="middle"><text x="85" y="24">1. proužek</text><text x="295" y="24">2. proužek</text><text x="540" y="24">3. proužek</text></g><text x="574" y="60" font-size="14">…</text><text x="503" y="92" font-size="12">✂</text></svg>',
  'paska.svg',
  'Papírová páska rozdělená na shodné čtverečky, tři odstřižené proužky (první, druhý, třetí) a vyznačená šířka pásky a údaj 2 cm u prvního proužku.',
  'Schematický nákres papírové pásky se třemi proužky',
  new List<String>{'Druhý proužek má $10$ čtverečků a je čtyřikrát delší než první, takže první proužek je dlouhý $2{,}5$ čtverečku.','6.1 Třetí proužek je šestkrát delší než první: $6 \\cdot 2{,}5 = 15$ čtverečků.','6.2 První proužek je $2$ čtverečky a $2$ cm, zároveň $2{,}5$ čtverečku; půl čtverečku je tedy $2$ cm, celý čtvereček (a tím i šířka pásky) $4$ cm.','6.3 Délka prvního proužku $= 2{,}5 \\cdot 4 = 10$ cm.'},
  '6.1: $15$ čtverečků; 6.2: $4$ cm; 6.3: $10$ cm',
  4, 6, '3',
  new List<String>{'zs1','planimetrie','modelovani','slovni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
