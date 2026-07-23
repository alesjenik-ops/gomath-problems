String SRC   = 'CERMAT – jednotná přijímací zkouška';
String STYPE = 'CERMAT';
String CCODE = 'M5PAD18C0T01';
Integer YEAR = 2018;

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
  'CERMAT M5A 2018 – úloha 13',
  new List<String>{'Krychle vlevo byla slepena ze $125$ bílých krychliček, má tedy v každé řadě $5$ krychliček. Krychle je na povrchu obarvena na šedo. Když se z každého rohu a ze středu každé stěny této krychle odebere jedna krychlička, vznikne těleso vpravo.','Přiřaďte ke každé otázce (13.1–13.3) odpovídající odpověď (A–F).','13.1 Kolik krychliček v tělese vpravo má právě jednu stěnu obarvenou na šedo?','13.2 Kolik krychliček v tělese vpravo má právě dvě stěny obarvené na šedo?','13.3 Kolik krychliček v tělese vpravo nemá obarvenou žádnou stěnu na šedo?'},
  new List<String>{'A) 27','B) 30','C) 36','D) 41','E) 48','F) jiný počet krychliček'},
  0,
  '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 560 285" font-family="sans-serif"><polygon points="40,80 80,40 210,40 170,80" fill="#bdbdbd" stroke="#000"/><polygon points="170,80 210,40 210,170 170,210" fill="#9e9e9e" stroke="#000"/><rect x="40" y="80" width="130" height="130" fill="#d0d0d0" stroke="#000"/><line x1="40" y1="80" x2="40" y2="210" stroke="#000" stroke-width="0.7"/><line x1="40" y1="80" x2="170" y2="80" stroke="#000" stroke-width="0.7"/><line x1="66" y1="80" x2="66" y2="210" stroke="#000" stroke-width="0.7"/><line x1="40" y1="106" x2="170" y2="106" stroke="#000" stroke-width="0.7"/><line x1="92" y1="80" x2="92" y2="210" stroke="#000" stroke-width="0.7"/><line x1="40" y1="132" x2="170" y2="132" stroke="#000" stroke-width="0.7"/><line x1="118" y1="80" x2="118" y2="210" stroke="#000" stroke-width="0.7"/><line x1="40" y1="158" x2="170" y2="158" stroke="#000" stroke-width="0.7"/><line x1="144" y1="80" x2="144" y2="210" stroke="#000" stroke-width="0.7"/><line x1="40" y1="184" x2="170" y2="184" stroke="#000" stroke-width="0.7"/><line x1="170" y1="80" x2="170" y2="210" stroke="#000" stroke-width="0.7"/><line x1="40" y1="210" x2="170" y2="210" stroke="#000" stroke-width="0.7"/><polygon points="330,80 370,40 500,40 460,80" fill="#bdbdbd" stroke="#000"/><polygon points="460,80 500,40 500,170 460,210" fill="#9e9e9e" stroke="#000"/><rect x="330" y="80" width="130" height="130" fill="#d0d0d0" stroke="#000"/><rect x="330" y="80" width="26" height="26" fill="#fff" stroke="#000"/><rect x="434" y="80" width="26" height="26" fill="#fff" stroke="#000"/><rect x="330" y="184" width="26" height="26" fill="#fff" stroke="#000"/><rect x="434" y="184" width="26" height="26" fill="#fff" stroke="#000"/><rect x="382" y="132" width="26" height="26" fill="#fff" stroke="#000"/><line x1="330" y1="80" x2="330" y2="210" stroke="#000" stroke-width="0.7"/><line x1="330" y1="80" x2="460" y2="80" stroke="#000" stroke-width="0.7"/><line x1="356" y1="80" x2="356" y2="210" stroke="#000" stroke-width="0.7"/><line x1="330" y1="106" x2="460" y2="106" stroke="#000" stroke-width="0.7"/><line x1="382" y1="80" x2="382" y2="210" stroke="#000" stroke-width="0.7"/><line x1="330" y1="132" x2="460" y2="132" stroke="#000" stroke-width="0.7"/><line x1="408" y1="80" x2="408" y2="210" stroke="#000" stroke-width="0.7"/><line x1="330" y1="158" x2="460" y2="158" stroke="#000" stroke-width="0.7"/><line x1="434" y1="80" x2="434" y2="210" stroke="#000" stroke-width="0.7"/><line x1="330" y1="184" x2="460" y2="184" stroke="#000" stroke-width="0.7"/><line x1="460" y1="80" x2="460" y2="210" stroke="#000" stroke-width="0.7"/><line x1="330" y1="210" x2="460" y2="210" stroke="#000" stroke-width="0.7"/><text x="105" y="255" font-size="12" text-anchor="middle">krychle 5×5×5</text><text x="395" y="255" font-size="12" text-anchor="middle">těleso po odebrání</text></svg>',
  'krychle-teleso.svg',
  'Vlevo krychle 5 krát 5 krát 5, vpravo stejná krychle s odebranými krychličkami z rohů a středů stěn.',
  'schematický nákres',
  new List<String>{'V krychli $5\\times5\\times5$ mají krychličky obarveno: $8$ rohových po $3$ stěnách, $36$ hranových (mimo rohy) po $2$ stěnách, $54$ stěnových po $1$ stěně a $27$ vnitřních žádnou. Odebere se $8$ rohových a $6$ středů stěn (stěnové, po $1$ obarvené stěně); nově vzniklé plochy nejsou obarvené.','13.1 Právě jednu obarvenou stěnu má $54-6=48$ krychliček → E.','13.2 Právě dvě obarvené stěny má $36$ krychliček (žádná se neodebrala) → C.','13.3 Žádnou obarvenou stěnu má $27$ vnitřních krychliček → A.'},
  '13.1: E (48); 13.2: C (36); 13.3: A (27)',
  5, 6, '4',
  new List<String>{'zs1','stereometrie','porozumeni','pocetni','bez-kalkulacky','bez-kontextu'}
);

System.debug('Vytvořeno úloh: '+c.created);
