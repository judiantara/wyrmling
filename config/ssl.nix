{lib, config, pkgs, hostname, ...}:
{
  age = {
    secrets = {
      "host-cert-bundle.pem" = {
        file = ../vault/${hostname}/${hostname}-cert-bundle.pem.age;
        path = "/etc/ssl/certs/host-cert-bundle.pem";
        mode = "444";
      };

      "host-cert.pem" = {
        file = ../vault/${hostname}/${hostname}-cert.pem.age;
        path = "/etc/ssl/certs/host-cert.pem";
        mode = "444";
      };

      "host-key.pem" = {
        file = ../vault/${hostname}/${hostname}-cert-key.pem.age;
        path = "/etc/ssl/certs/host-key.pem";
        mode = "444";
      };
    };
  };

  security.pki.certificates = [
    ''
      OpikCA
      ======
      -----BEGIN CERTIFICATE-----
      MIICATCCAaigAwIBAgIUUgc8uKcAP+E/V4Ar14PYy1yd56owCgYIKoZIzj0EAwIw
      XzELMAkGA1UEBhMCSUQxETAPBgNVBAgTCFN1cmFiYXlhMRIwEAYDVQQHEwlFYXN0
      IEphdmExEjAQBgNVBAoTCU9waWsgSW5jLjEVMBMGA1UEAxMMT3BpayBJbmMuIENB
      MB4XDTI1MDMwOTEwMjUwMFoXDTMwMDMwODEwMjUwMFowXzELMAkGA1UEBhMCSUQx
      ETAPBgNVBAgTCFN1cmFiYXlhMRIwEAYDVQQHEwlFYXN0IEphdmExEjAQBgNVBAoT
      CU9waWsgSW5jLjEVMBMGA1UEAxMMT3BpayBJbmMuIENBMFkwEwYHKoZIzj0CAQYI
      KoZIzj0DAQcDQgAE54hCxJJcIqfjWNnBS16GTemx2w7d43G02NZtGVlNgSkyHoq3
      t7989LreKvW4v+7W1pb4IAIysIrDQcAb+MT9+qNCMEAwDgYDVR0PAQH/BAQDAgEG
      MA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFBp31d4NJFL0aKYln8Wm6s6EBVJF
      MAoGCCqGSM49BAMCA0cAMEQCIFRcE0VRLWD/ZgeE5nEUM+UOCGkSkxP4ugQ4E9w+
      JiERAiAnVnYgmvoAXooraZINBd1Rs8/kx4eXFdk4XsEkV+JoLQ==
      -----END CERTIFICATE-----
    ''
  ];

  environment ={
    etc = {
      "ssl/certs/ca-cert.pem" = {
        text = ''
          -----BEGIN CERTIFICATE-----
          MIICATCCAaigAwIBAgIUUgc8uKcAP+E/V4Ar14PYy1yd56owCgYIKoZIzj0EAwIw
          XzELMAkGA1UEBhMCSUQxETAPBgNVBAgTCFN1cmFiYXlhMRIwEAYDVQQHEwlFYXN0
          IEphdmExEjAQBgNVBAoTCU9waWsgSW5jLjEVMBMGA1UEAxMMT3BpayBJbmMuIENB
          MB4XDTI1MDMwOTEwMjUwMFoXDTMwMDMwODEwMjUwMFowXzELMAkGA1UEBhMCSUQx
          ETAPBgNVBAgTCFN1cmFiYXlhMRIwEAYDVQQHEwlFYXN0IEphdmExEjAQBgNVBAoT
          CU9waWsgSW5jLjEVMBMGA1UEAxMMT3BpayBJbmMuIENBMFkwEwYHKoZIzj0CAQYI
          KoZIzj0DAQcDQgAE54hCxJJcIqfjWNnBS16GTemx2w7d43G02NZtGVlNgSkyHoq3
          t7989LreKvW4v+7W1pb4IAIysIrDQcAb+MT9+qNCMEAwDgYDVR0PAQH/BAQDAgEG
          MA8GA1UdEwEB/wQFMAMBAf8wHQYDVR0OBBYEFBp31d4NJFL0aKYln8Wm6s6EBVJF
          MAoGCCqGSM49BAMCA0cAMEQCIFRcE0VRLWD/ZgeE5nEUM+UOCGkSkxP4ugQ4E9w+
          JiERAiAnVnYgmvoAXooraZINBd1Rs8/kx4eXFdk4XsEkV+JoLQ==
          -----END CERTIFICATE-----
        '';
      };
    };
  };
}
